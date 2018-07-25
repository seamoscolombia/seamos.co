require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  describe 'Post create' do
    before(:each) do
      session[:email] = user.email
    end
    let(:user) { FactoryGirl.create(:user, role_type: 2) }
    let(:poll) { FactoryGirl.create(:poll) }
    let(:vote_type) { FactoryGirl.create(:vote_type, poll: poll) }
    it 'creates a vote' do
      previous_count = Vote.count
      post :create, params: { vote: { vote_type_id: vote_type.id } }
      new_count = Vote.count
      expect(previous_count).not_to be eq(new_count)
    end
  end
end
