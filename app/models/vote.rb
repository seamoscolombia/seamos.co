# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  poll_id      :integer
#  user_id      :integer
#  vote_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :user
  belongs_to :vote_type, optional: true

  validate :vote_date, on: :create

  delegate :name, :to => :vote_type, :allow_nil => true

  def vote_date
    if poll.closing_date < Date.current
      errors.add(:base, I18n.t( :closed_poll, scope: :votes))
    end
  end
  scope :by_user_id, -> (user_id) { where(user_id: user_id) }
end
