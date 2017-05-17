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

  describe 'POST create' do
    let(:user) { FactoryGirl.create(:user, role_type: 2) }
    before(:each) do
      Tag.destroy_all
      session[:email] = user.email
      post :create, params: {
        tag: {
          name: 'newtag',
          tag_image: File.open("#{Rails.root}/spec/support/image.png", 'r')
        }
      }
    end
    it 'Creates a new tag' do
      expect(Tag.find_by(name: 'newtag')).not_to be nil
    end
    it 'should return status found' do
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET new' do
    before(:each) do
      session[:email] = user.email
      get :new
    end
    let(:user) { FactoryGirl.create(:user, role_type: 2) }
    it 'assigns a new tag to @tag' do
      expect(assigns(:tag).new_record?).to be true
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end

    it 'should return status ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE delete' do
    before(:each) do
      session[:email] = user.email
      delete :delete, params: { id: tag.id }
    end
    let(:tag) { FactoryGirl.create(:tag) }
    let(:user) { FactoryGirl.create(:user, role_type: 2) }
    it 'deletes the tag' do
      expect(Tag.exists?(tag.id)).to eq false
    end
    it 'should return status found' do
      expect(response).to have_http_status(:found)
    end
  end
end