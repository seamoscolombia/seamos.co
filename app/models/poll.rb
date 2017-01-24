# == Schema Information
#
# Table name: polls
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  private      :boolean          default(TRUE), not null
#  closing_date :date             not null
#  usuario_id   :integer
#  totals       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  url_image    :string
#  poll_image   :string
#

class Poll < ApplicationRecord
  mount_uploader :poll_image, PollImageUploader

  belongs_to :usuario
  has_many :debates
  has_many :votes
  has_many :vote_types, inverse_of: :poll
  accepts_nested_attributes_for :vote_types


  validates :title, presence: true
  validates :closing_date, presence: true
  validates :description, presence: true
  validates :poll_image, presence: true, on: :create

  validate :closing_date_validation

  def closed?
    closing_date < Date.today
  end

  private
    def closing_date_validation
      if closing_date < Date.today
        errors.add(:closing_date, I18n.t(:fecha_invalida))
      end
    end

    def has_at_least_two_vote_types
      if vote_types.length < 2
        errors.add(:base, I18n.t( :at_least_two_options, scope: :polls))
      end
    end
end
