# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  poll_id      :integer
#  user_id      :integer
#  vote_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'relations' do
    it { should belong_to(:poll) }
    it { should belong_to(:user) }
    it { should belong_to(:vote_type) }
  end
  let(:poll) { FactoryGirl.create(:poll, closing_date: Date.today - 5.days) }
  let(:vote) { FactoryGirl.build(:vote, poll: poll) }
  it 'should validate vote date' do
    vote.valid?
    expect(vote.errors[:base]).to include 'La propuesta ya ha cerrado.'
  end
end
