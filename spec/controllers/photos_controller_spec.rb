require 'rails_helper'
include SessionsHelper

RSpec.describe PhotosController, type: :controller do
  describe 'POST create' do
    it 'should return status created' do
      post :create, params: {photo: "photo_string"}
      expect(response).to have_http_status(:created)
    end
  end
end
