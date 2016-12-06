# == Schema Information
#
# Table name: causes
#
#  id             :integer          not null, primary key
#  description    :text             not null
#  title          :string           not null
#  state_cause_id :integer          not null
#  usuario_id     :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class CauseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # test "the truth" do
  #   assert true
  # end
end
