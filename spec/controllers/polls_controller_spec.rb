require 'rails_helper'
include SessionsHelper

RSpec.describe PollsController, type: :controller do
  describe 'GET index' do
    context 'when the request format is JSON' do
      it 'assigns @polls' do
        5.times { FactoryGirl.create(:poll) }
        all_polls = Poll.all
        get :index, format: :json
        expect(assigns(:polls)).to match_array(all_polls)
      end
    end

    context 'when the request format is JSON' do
      it 'assigns @polls' do
        5.times { FactoryGirl.create(:poll) }
        all_polls = Poll.all
        get :index
        expect(assigns(:polls)).to match_array(all_polls)
      end
    end

    describe "responds to" do
      it "responds to html by default" do
        get :index
        expect(response.content_type).to eq "text/html"
      end

      it "responds to custom formats when provided in the params" do
        get :index, format: :json
        expect(response.content_type).to eq "application/json"
      end
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'should return status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
  describe 'GET edit' do
    context 'when the user is not an admin' do
      let(:poll) { FactoryGirl.create(:poll) }
      it 'assigns redirects to root path' do
        get :edit, params: {id: poll.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the user is an admin' do
      let(:poll) { FactoryGirl.create(:poll) }
      let(:user) { FactoryGirl.create(:user, role_type: 2)}
      it 'renders the edit template' do
        session[:email] = user.email
        get :edit, params: {id: poll.id}
        expect(response).to render_template(:edit)
      end
    end
  end
end
