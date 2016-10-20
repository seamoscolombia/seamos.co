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

require 'test_helper'

class VoteTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
