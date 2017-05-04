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
        all_tags = Tag.all.map(&:name)
        get :index
        expect(assigns(:tags)).to eq(all_tags)
      end
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST create' do
    let(:user) { FactoryGirl.create(:usuario, role_type: 2) }
    it 'Creates a new tag' do
      session[:email] = user.email
      post :create, params: { tag: { name: 'new_tag' } }
      expect(Tag.find_by(name: 'new_tag')).not_to be nil
    end
  end

  describe 'GET new' do
    let(:user) { FactoryGirl.create(:usuario, role_type: 2) }
    it 'assigns a new tag to @tag' do
      session[:email] = user.email
      get :new
      expect(assigns(:tag).new_record?).to be true
    end

    it 'renders the new template' do
      session[:email] = user.email
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'DELETE delete' do
    let(:tag) { FactoryGirl.create(:tag) }
    let(:user) { FactoryGirl.create(:usuario, role_type: 2) }
    it 'deletes the tag' do
      session[:email] = user.email
      delete :delete, params: { id: tag.id }
      expect(Tag.exists?(tag.id)).to eq false
    end
  end
end
