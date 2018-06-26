require 'rails_helper'
include SessionsHelper

RSpec.describe Admin::TagsController, type: :controller do
  describe 'POST create' do
    let(:user) { FactoryGirl.create(:user, role_type: 2) }
    let(:new_tag_params) { FactoryGirl.attributes_for(:tag, name: 'newtag') }
    before(:each) do
      Tag.destroy_all
      allow_any_instance_of(Tag).to receive(:valid?).and_return(true)
      sign_in user
      post :create, params: {
        tag: new_tag_params
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
    let(:user) { FactoryGirl.create(:user, role_type: 2) }
    before(:each) do
      sign_in user
      get :new
    end
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

  describe 'DELETE destroy' do
    before(:each) do
      session[:email] = user.email
      delete :destroy, params: { id: tag.id }
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
