# == Schema Information
#
# Table name: debates
#
#  id         :integer          not null, primary key
#  title      :string
#  published  :boolean          default(FALSE)
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DebateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
