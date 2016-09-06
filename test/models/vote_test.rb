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

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
