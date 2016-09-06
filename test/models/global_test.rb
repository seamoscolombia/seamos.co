# == Schema Information
#
# Table name: globals
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  value      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class GlobalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
