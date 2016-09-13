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
#

class Poll < ApplicationRecord
  belongs_to :usuario
  has_many :votes

  validates :title, presence: true
  validates :closing_date, presence: true
  validates :description, presence: true

  validate :closing_date_validation

  def closing_date_validation
    if closing_date < Date.today
      #TODO change to Format I18n Rails errors Message
      errors.add(:closing_date, I18n.t(:fecha_invalida))
    end
  end

  def closed?
    closing_date < Date.today
  end
end