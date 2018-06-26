# == Schema Information
#
# Table name: users
#
#  id                                        :integer          not null, primary key
#  first_surname                             :string
#  second_surname                            :string
#  names                                     :string
#  uid                                       :string
#  approved                                  :boolean
#  created_at                                :datetime         not null
#  updated_at                                :datetime         not null
#  email                                     :string
#  password_hash                             :string
#  password_salt                             :string
#  role_type                                 :integer
#  admin_photo                               :string
#  organization                              :string
#  bio                                       :string
#  birthday                                  :date
#  birthplace                                :string
#  last_election_vote_count                  :integer
#  represented_organizations                 :text
#  major_electoral_representation_localities :string
#  other_periods_elected                     :string
#  current_corporation_commission            :integer
#  proposed_initiatives_to_date              :text
#  twitter_username                          :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relations' do
    it { should have_many(:polls) }
    it { should have_many(:voted_polls) }
    it { should have_many(:votes) }
    it { should have_many(:interests) }
    it { should have_many(:tags) }
  end

  describe 'enums' do
    it { should define_enum_for(:role_type) }
    it { should define_enum_for(:current_corporation_commission) }
  end

  describe 'validations' do
    describe 'admin validations' do
      let(:invalid_admin) { User.new(role_type: 2, uid: '', email: nil) }
      it 'should validate email' do
        invalid_admin.valid?
        expect(invalid_admin.errors[:email].empty?).to be false
      end
    end
    describe 'politician validations' do
      subject { FactoryGirl.create(:user, role_type: 1) }
      it { should validate_presence_of(:bio) }
      it { should validate_presence_of(:organization) }
      it { should validate_presence_of(:admin_photo) }
    end
  end

  describe 'User#full_name' do
    let(:user) { FactoryGirl.build(:user, names: 'John', first_surname: 'Dummy', second_surname: 'Doe') }
    context 'when user has names, first_surname y second_surname' do
      it 'returns user full name' do
        expect(user.full_name).to eq('John Dummy Doe')
      end
    end
  end

  describe 'User#already_voted?' do
    let(:user) { FactoryGirl.create(:user) }
    let(:voted_poll) { FactoryGirl.create(:poll_with_votes) }
    let(:non_voted_poll) { FactoryGirl.create(:poll) }
    context 'when user has already voted for a poll' do
      it 'returns true' do
        user.votes << voted_poll.votes.first
        expect(user.already_voted?(voted_poll)).to be true
      end
    end
    context 'when user has not voted for a poll' do
      it 'returns false' do
        expect(user.already_voted?(non_voted_poll)).to be false
      end
    end
  end
end