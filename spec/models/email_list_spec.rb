# == Schema Information
#
# Table name: email_lists
#
#  id         :integer          not null, primary key
#  name       :string
#  identifier :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe EmailList, type: :model do
  describe 'relations' do
    it { should have_many(:subscriptions) }
  end
  describe '#create_subscriptions' do
    let(:email_list) { FactoryGirl.create(:email_list)}
    let(:mails) { "testmail@test.com, testmail2@test.com, testmail3@test.com , testmail4@test.com"}
    it 'creates a new subscription for each mail passed as argument' do
      email_list.create_subscriptions(mails)
      expect(Subscription.count).to eq(4)
      expect(Subscription.pluck(:email)).to match_array(['testmail@test.com', 'testmail2@test.com', 'testmail3@test.com' , 'testmail4@test.com'])
    end
  end
end
