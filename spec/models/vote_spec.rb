require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'relations' do
    it { should belong_to(:poll) }
    it { should belong_to(:usuario) }
    it { should belong_to(:vote_type) }
  end
  let(:poll) { FactoryGirl.create(:poll, closing_date: Date.today - 5.days) }
  let(:vote) { FactoryGirl.build(:vote, poll: poll) }
  it 'should validate vote date' do
    vote.valid?
    expect(vote.errors[:base]).to include 'La propuesta ya ha cerrado.'
  end
end
