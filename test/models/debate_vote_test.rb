# == Schema Information
#
# Table name: debate_votes
#
#  id          :integer          not null, primary key
#  question_id :integer
#  usuario_id  :integer
#  debate_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class DebateVoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
