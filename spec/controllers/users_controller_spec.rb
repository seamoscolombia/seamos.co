require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  describe 'GET index' do
    context 'when the request format is HTML' do
      it 'get users' do
        5.times { FactoryGirl.create(:user) }
        get :index
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'POST create' do
    context 'request as json' do
      it 'An citizen user is created' do
          session[:uid] = rand(300).to_s
          my_params =  {
              first_surname:  Faker::Name.last_name,
              second_surname: Faker::Name.last_name,
              names: Faker::Name.first_name,
              email: Faker::Internet.email,
            }

          post :create, params: { user: my_params }, format: :json
          expect(response).to have_http_status(:created)
      end
    end
  end
end
