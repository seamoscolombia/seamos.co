require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  let(:subscription) { FactoryGirl.create(:subscription) }
  let(:encrypted_subscription_id) { Rails.application.message_verifier(:unsubscribe).generate(subscription.id) }

  describe "GET #unsubscribe" do
    it "returns http success" do
      get :unsubscribe, params: { id: encrypted_subscription_id }
      expect(response).to have_http_status(:success)
    end
  end

end
