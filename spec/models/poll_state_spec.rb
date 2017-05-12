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

require 'rails_helper'

RSpec.describe PollState, type: :model do
  describe 'relations' do
    it { should belong_to(:poll) }
  end
  describe 'enums' do
    it { should define_enum_for(:status) }
  end
end
