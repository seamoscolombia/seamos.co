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

require 'rails_helper'

RSpec.describe Poll, type: :model do
  describe 'relations' do
    it { should belong_to(:user) }
    it { should have_many(:vote_types) }
    it { should have_many(:votes) }
    it { should have_many(:debates) }
    it { should accept_nested_attributes_for(:vote_types) }
  end


  describe 'validations' do
    let(:poll) { Poll.new(closing_date: Date.today - 3.days) }
    it 'should validate closing_date' do
      poll.valid?
      expect(poll.errors[:closing_date]).to include('Fecha Inválida')
    end
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:closing_date) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:poll_image) }
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

  describe 'poll#published_debates?' do
    let(:poll) { FactoryGirl.create(:poll_with_votes_and_debates) }
    context 'when poll has not published debates' do
      it 'returns an empty array' do
        expect(poll.published_debates).to eq([])
      end
    end
    context 'when poll has published debates' do
      it 'returns only publshed debates' do
        debates = poll.debates
        debates.first.update(published: true)
        debates.last.update(published: true)
        expect(poll.published_debates).to include(debates.first, debates.last)
      end
    end
  end
end
