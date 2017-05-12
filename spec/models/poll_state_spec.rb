require 'rails_helper'

RSpec.describe PollState, type: :model do
  describe 'relations' do
    it { should belong_to(:poll) }
  end
  describe 'enums' do
    it { should define_enum_for(:status) }
  end
end
