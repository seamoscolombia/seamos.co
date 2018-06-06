require 'rails_helper'
include SessionsHelper

RSpec.describe TagsController, type: :controller do
  describe 'GET index' do
    context 'when the request format is JSON' do
      it 'assigns @tags' do
        5.times { FactoryGirl.create(:tag) }
        all_tags = Tag.all
        get :index, format: :json
        expect(assigns(:tags)).to eq(all_tags)
      end
    end

    context 'when the request format is html' do
      it 'assigns @tags' do
        5.times { FactoryGirl.create(:tag) }
        all_tags = Tag.all
        get :index
        expect(assigns(:tags)).to eq(all_tags)
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

  describe 'GET user_interests' do
    context 'when the request format is JSON' do
      it 'assigns @tags' do
        5.times { FactoryGirl.create(:interest) }
        all_tags = Tag.all
        get :index, format: :json
        expect(assigns(:tags)).to eq(all_tags)
      end
    end
  end
end
