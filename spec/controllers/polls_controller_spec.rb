require 'rails_helper'

RSpec.describe PollsController, type: :controller do
  describe 'GET show' do
    let(:poll) { FactoryGirl.create(:poll_with_votes_and_tags)}
    it 'assigns @poll' do
      get :show, params: { id: poll.id }
      expect(assigns(:poll)).to eq(poll)
    end

    it 'renders the show template' do
      get :show, params: { id: poll.id }
      expect(response).to render_template('show')
    end

    it 'should return status ok' do
      get :show, params: { id: poll.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
