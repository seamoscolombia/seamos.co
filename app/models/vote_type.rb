# == Schema Information
#
# Table name: vote_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VoteType < ApplicationRecord
  belongs_to :poll, inverse_of: :vote_types

  validates :name, presence: true
  validates :poll, presence: true
  scope :by_name, -> (name) { where(name: name) }
end
