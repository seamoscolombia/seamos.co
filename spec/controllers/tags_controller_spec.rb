require 'rails_helper'
include SessionsHelper

RSpec.describe TagsController, type: :controller do
  describe 'GET index' do
    context 'when the request format is html' do
      it 'assigns @tags' do
        5.times { FactoryGirl.create(:tag_with_polls) }
        all_tags = Tag.all
        get :index
        expect(assigns(:tags)).to match_array(all_tags)
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
