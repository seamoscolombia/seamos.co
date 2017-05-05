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
end
