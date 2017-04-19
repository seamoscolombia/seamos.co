# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  poll_id      :integer
#  usuario_id   :integer
#  vote_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :user
  belongs_to :vote_type, optional: true

  validate :vote_date, on: :create

  def vote_date
    if poll.closing_date < Date.today
      errors.add(:base, I18n.t( :closed_poll, scope: :votes))
    end
  end
end
