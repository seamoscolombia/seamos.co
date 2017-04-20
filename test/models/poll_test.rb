# == Schema Information
#
# Table name: polls
#
#  id            :integer          not null, primary key
#  title         :string           not null
#  description   :text             not null
#  private       :boolean          default(TRUE), not null
#  closing_date  :date             not null
#  usuario_id    :integer
#  totals        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  poll_image    :string
#  active        :boolean          default(TRUE)
#  poll_document :string
#

require 'test_helper'

class PollTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
