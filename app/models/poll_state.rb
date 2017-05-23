# == Schema Information
#
# Table name: poll_states
#
#  id               :integer          not null, primary key
#  name             :string
#  status           :integer
#  ordinal_position :integer
#  poll_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class PollState < ApplicationRecord
  belongs_to :poll
  enum status: {rejected: 0, neutro: 1, approved: 2}
end
