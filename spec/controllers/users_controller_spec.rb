require 'rails_helper'

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
    context 'and the user is not logged in' do
      it 'redirects to sign in path' do
        get :show, id: 12
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'and the user is logged in' do
      before(:each) do
        sign_in user
      end
      it 'assigns @user' do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end
      it 'renders the show template' do
        get :show, params: { id: user.id }
        expect(response).to render_template('show')
      end
      it 'should return status ok' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end

    end
  end
end
