# == Schema Information
#
# Table name: polls
#
#  id            :integer          not null, primary key
#  title         :string           not null
#  description   :text             not null
#  closing_date  :date             not null
#  usuario_id    :integer
#  totals        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  poll_image    :string
#  active        :boolean          default(TRUE)
#  poll_document :string
#

class Poll < ApplicationRecord
  mount_uploader :poll_image, PollImageUploader
  mount_uploader :poll_document, PollDocumentUploader

  belongs_to :usuario
  has_many :vote_types, inverse_of: :poll, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :debates, dependent: :destroy
  accepts_nested_attributes_for :vote_types
  has_many :taggings, dependent: :destroy
  has_many :tags, -> { distinct }, through: :taggings

  validates :title, presence: true
  validates :closing_date, presence: true
  validates :description, presence: true
  validates :poll_image, presence: true, on: :create
  validates :poll_document, presence: true, on: :create

  validate :closing_date_validation
  validate :at_least_one_tag

  scope :active, -> {
    where('active IS TRUE AND closing_date >= ?', Date.today)
  }
  scope :inactive, -> {
    where('active IS FALSE OR closing_date < ?', Date.today)
  }

  def self.by_status(status)
    if status == 'inactive'
      inactive
    elsif status == 'active'
      active
    else
      all
    end
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
      errors.add(:at_least_one_tag, I18n.t(:at_least_one_tag, scope: :polls))
    end
  end
end
