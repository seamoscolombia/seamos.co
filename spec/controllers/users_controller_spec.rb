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

  describe 'GET show' do
   let(:user) { FactoryGirl.create(:user)}
   context 'when the request format is JSON' do
     context 'and the user is not logged in' do

       it 'renders an error' do
         get :show, format: :json
         expect(JSON.parse(response.body)["errors"]).to eq("El usuario debe iniciar sesión para ver su informacion de perfil")
       end

     end
     context 'and the user is logged in' do

       before(:each) do
         session[:email] = user.email
       end

       it 'assigns @user' do
         get :show, params: { id: user.id }, format: :json
         expect(assigns(:user)).to eq(user)
       end

       it 'renders the show template' do
         get :show, params: { id: user.id }, format: :json
         expect(response).to render_template('show')
       end

       it 'should return status ok' do
         get :show, params: { id: user.id }, format: :json
         expect(response).to have_http_status(:ok)
       end

     end
   end

   describe "responds to" do
     it "responds to JSON by default" do
       get :show, params: { id: user.id }
       expect(response.content_type).to eq "application/json"
     end

     it "responds to custom formats when provided in the params" do
       get :show, params: { id: user.id }, format: :json
       expect(response.content_type).to eq "application/json"
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
