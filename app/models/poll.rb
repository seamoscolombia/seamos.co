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
#

class Poll < ApplicationRecord
  mount_uploader :poll_image, PollImageUploader

  attr_accessor :links
  belongs_to :user
  has_many :vote_types, inverse_of: :poll, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :debates, dependent: :destroy
  accepts_nested_attributes_for :vote_types
  has_many :taggings, dependent: :destroy
  has_many :tags, -> { distinct }, through: :taggings
  has_many :external_links, dependent: :destroy
  has_many :poll_states

  validates :title, presence: true
  validates :closing_date, presence: true
  validates :description, presence: true
  validates :objective, presence: true
  validates :poll_image, presence: true, on: :create

  validate :closing_date_validation
  validate :has_one_tag
  validate :has_only_one_tag

  enum poll_type: {voting: 0, participation: 1, signing: 2}
  enum state: {"Votación abierta": 0,
                   "En el concejo": 1,
                   "propuesta de acuerdo": 2,
                   "En el concejox": 3}

  scope :active, -> {
    where('active IS TRUE AND closing_date >= ?', Date.today)
  }
  scope :inactive, -> {
    where('active IS FALSE OR closing_date < ?', Date.today)
  }

  scope :open, -> {
    where('closing_date > ?', Date.today)
  }

  scope :closed, -> {
    where('closing_date <= ?', Date.today)
  }

  scope :get_user_participations, -> (user) {
    joins(:votes).where("votes.user_id = ?", user.id)
  }

  scope :by_title, -> (poll_title) {
    where("title LIKE ?", "%#{poll_title}%")
  }

  def self.search(search_term)
    if search_term
      by_title(search_term)
    else
      find(:all)
    end
  end

  def self.by_status(status)
    if status == 'inactive'
      inactive
    elsif status == 'active'
      active
    else
      all
    end
  end

  def poll_state
    Poll.states[state ? state : 0].to_i
  end

  def closed?
    closing_date && closing_date < Date.today
  end

  def published_debates
    debates.where(published: true)
  end

  def import_csv
    # TODO: csv reader
    # format: email1, email2, ... ,emailN
    raise NotImplementedError
  end

  def set_tags(tag_list)
    tags << Tag.where(name: tag_list.split(','))
  end

  def remaining_time_in_seconds
    (closing_date - Date.today) * 1.days
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

  def has_only_one_tag
    unless tags.size < 2
      errors.add(:base, I18n.t(:only_one_tag, scope: :polls))
    end
  end

  def has_one_tag
    unless tags.present?
      errors.add(:base, I18n.t(:one_tag, scope: :polls))
    end
  end
end
