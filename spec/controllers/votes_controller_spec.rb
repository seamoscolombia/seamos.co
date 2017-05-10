require 'rails_helper'
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  describe 'Post create' do
    before(:each) do
      session[:email] = user.email
    end
    let(:user) { FactoryGirl.create(:usuario, role_type: 2) }
    let(:poll) { FactoryGirl.create(:poll) }
    let(:vote_type) { FactoryGirl.create(:vote_type, poll: poll) }
    it 'creates a vote' do
      post :create, params: { vote: { vote_type_id: vote_type.id } }
      expect(response).to have_http_status(:found)
    end
  end
end
