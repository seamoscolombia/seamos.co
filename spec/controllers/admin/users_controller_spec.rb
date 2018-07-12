require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  describe 'GET index' do
    context 'when the request format is HTML' do
      it 'get users' do
        5.times { FactoryGirl.create(:user) }
        get :index
        expect(response).to have_http_status(:found)
      end
    end
  end
end