# == Schema Information
#
# Table name: polls
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  closing_date :date             not null
#  user_id      :integer
#  totals       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  poll_image   :string
#  active       :boolean          default(TRUE)
#  poll_type    :integer
#  objective    :string
#  summary      :string
#  question     :string
#  state        :integer
#  closing_hour :string
#

require 'rails_helper'

RSpec.describe Poll, type: :model do
  describe 'relations' do
    it { should belong_to(:user) }
    it { should have_many(:vote_types) }
    it { should have_many(:votes) }
    it { should have_many(:external_links) }
    it { should accept_nested_attributes_for(:vote_types) }
  end

  describe 'enums' do
    it { should define_enum_for(:poll_type) }
  end

  describe 'validations' do
    let(:poll) { FactoryGirl.create(:poll) }
    it 'should validate closing_date' do
      poll.update(closing_date: Date.today - 3.days)
      poll.valid?
      expect(poll.errors[:closing_date].empty?).to be true
    end
    let(:poll) { FactoryGirl.create(:poll) }
    it 'should validate at least one tag selected' do
      poll.valid?
      expect(poll.errors[:at_least_one_tag].empty?).to be false
      expect(poll.errors[:at_least_one_tag]).to match_array(["Debes seleccionar por lo menos un tema para la propuesta."])
    end
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:closing_date) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:poll_image) }
  end

  describe 'named scopes' do
    let(:poll_1) { FactoryGirl.create(:poll, closing_date: Date.today - 3.days) }
    let(:poll_2) { FactoryGirl.create(:poll, closing_date: Date.today + 3.days) }
    let(:poll_3) { FactoryGirl.create(:poll, closing_date: Date.today + 3.days, active: false) }
    describe 'active' do
      it 'returns only polls that are active' do
        expect(Poll.active).to include(poll_1, poll_2)
        expect(Poll.active).not_to include(poll_3)
      end
    end
    describe 'inactive' do
      it 'returns only polls that are inactive or closed' do
        expect(Poll.inactive).not_to include(poll_2)
        expect(Poll.inactive).to include(poll_1, poll_3)
      end
    end
  end

  describe 'poll#closed?' do
    let(:poll) { FactoryGirl.build(:poll, closing_date: Date.today - 3.days) }
    context 'when poll closing date has passed' do
      it 'returns true' do
        expect(poll.closed?).to eq(true)
      end
    end
    context 'when poll closing date has not passed yet' do
      it 'returns false' do
        poll.update(closing_date: Date.today + 3.days)
        expect(poll.closed?).to eq(false)
      end
    end
  end

  describe 'poll#set_tags()' do
    let(:poll) { FactoryGirl.create(:poll) }
    let(:tag_1) { FactoryGirl.create(:tag) }
    let(:tag_2) { FactoryGirl.create(:tag) }
    let(:tag_3) { FactoryGirl.create(:tag) }
    context 'when coma separated tag names are passed as argument to the method' do
      it 'adds tags to poll' do
        poll.set_tags("#{tag_1.name},#{tag_3.name}")
        expect(poll.tags).to match_array([tag_1, tag_3])
      end
      it 'adds the right amount of tags' do
        poll.set_tags("#{tag_1.name},#{tag_3.name}")
        expect(poll.tags.count).to eq 2
      end
    end
    context 'when a tag is not passed as argument to the method' do
      it 'should not add the tag' do
        poll.set_tags("#{tag_1.name},#{tag_3.name}")
        expect(poll.tags).not_to include(tag_2)
      end
    end
  end

  describe 'Poll.by_status()' do
    let(:poll_1) { FactoryGirl.create(:poll, closing_date: Date.today - 3.days) }
    let(:poll_2) { FactoryGirl.create(:poll, closing_date: Date.today + 3.days) }
    let(:poll_3) { FactoryGirl.create(:poll, closing_date: Date.today + 3.days, active: false) }
    context 'when the passed status is inactive' do
      it 'returns inactive polls' do
        expect(Poll.by_status("inactive")).to match_array([poll_1, poll_3])
      end
    end
    context 'when the passed status is active' do
      it 'returns active polls' do
        expect(Poll.by_status("active")).to match_array(poll_2)
      end
    end
  end
end
