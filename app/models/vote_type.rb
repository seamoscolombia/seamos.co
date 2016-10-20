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
  validates :name, presence: true
  belongs_to :poll, inverse_of: :vote_types
 validates_presence_of :poll
end
