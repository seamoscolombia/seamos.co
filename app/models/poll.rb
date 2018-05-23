# == Schema Information
#
# Table name: polls
#
#  id            :integer          not null, primary key
#  title         :string           not null
#  description   :text             not null
#  closing_date  :date             not null
#  user_id       :integer
#  totals        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  poll_image    :string
#  active        :boolean          default(TRUE)
#  poll_document :string
#  poll_type     :integer
#  objective     :string
#  summary       :string
#  question      :string
#  state         :integer
#  closing_hour  :string
#

class Poll < ApplicationRecord
  mount_uploader :poll_image, PollImageUploader

  attr_accessor :links
  belongs_to :user
  has_many :vote_types, inverse_of: :poll, dependent: :destroy
  has_many :votes, dependent: :destroy
  accepts_nested_attributes_for :vote_types
  has_many :taggings, dependent: :destroy
  has_many :tags, -> { distinct }, through: :taggings

  has_many :external_links, dependent: :destroy
  has_one :project_link, -> { where(is_project_link: true) }, class_name: 'ExternalLink'

  validates :title, presence: true
  validates :closing_date, presence: true
  validates :description, presence: true
  validates :objective, presence: true
  validates :poll_image, presence: true, on: :create

  # validate :closing_date_validation
  validate :at_least_one_tag

  enum poll_type: {
                    "Voto o proyecto de acuerdo": 1,
                    "Control político": 0
                  }
  enum state: {
                "Votación seamos": 0,
                "Radica concejal": 1,
                "Primer debate": 2,
                "Segundo debate": 3,
                "Sanción del proyecto de acuerdo": 4
              }

  scope :active, -> {
    where('active IS TRUE')
  }

  scope :inactive, -> {
    where('active IS FALSE OR closing_date < ?', Date.current)
  }

  scope :open, -> {
    select{|p| !p.closed?}
  }

  scope :closed, -> {
    select{|p| p.closed?}
  }

  scope :get_user_participations, -> (user) {
    joins(:votes).where("votes.user_id = ?", user.id)
  }

  scope :by_title, -> (poll_title) {
    where("title ILIKE ?", "%#{poll_title}%")
  }

  def self.search(search_term)
    if search_term
      by_title(search_term)
    else
      find(:all)
    end
  end

  def self.by_status(status)
    if status == 'closed'
      closed
    elsif status == 'open'
      open
    else
      all
    end
  end

  def poll_state
    Poll.states[state ? state : 0].to_i
  end

  def closed?
    closing_date && closing_date == Date.current &&
    closing_hour && closing_hour <= Time.zone.now.strftime("%H:%M:%S") ||
    closing_date < Date.current
  end

  def voted_by_user?(user_id)
    votes.pluck(:user_id).include?(user_id)
  end

  def set_tags(tag_list)
    tags << Tag.where(name: tag_list.split(','))
  end

  def remaining_time_in_seconds
    if closing_hour && closing_hour != "" && closing_date == Date.current
      Time.zone.parse(closing_hour) - Time.zone.now
    elsif closing_date >= Date.current
      ( closing_date - Date.current ) * 1.days + 1.days
    else
      ( closing_date - Date.current ) * 1.days
    end
  end

  def remaining_time_in_seconds_from_created
    (closing_date - created_at.to_datetime) * 1.days
  end

  def vote_count
    votes.size
  end

  def self.by_user_interests(user)
    Tag.where(id: user.tag_ids).includes(:polls).map(&:polls).flatten.uniq
  end

  def related_links
    external_links.where(is_project_link: false)
  end

  private

  def closing_date_validation
    if closed?
      errors.add(:closing_date, I18n.t(:fecha_invalida))
    end
  end

  def has_at_least_two_vote_types
    if vote_types.length < 2
      errors.add(:base, I18n.t(:at_least_two_options, scope: :polls))
    end
  end

  def at_least_one_tag
    unless tags.present?
      errors.add(:base, I18n.t(:one_tag, scope: :polls))
    end
  end
end
