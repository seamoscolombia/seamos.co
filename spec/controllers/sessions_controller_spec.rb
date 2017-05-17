require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  context "POST create" do
    #Create new user
    let(:user) { FactoryGirl.create(:user) }

    #Params for a non registered user
    let (:not_registered_user) {ActionController::Parameters.new(
      { session: {email: "notuser@user.com", password: "password" }
      })
    }
    #Params for a registered user
    let (:registered_user) {ActionController::Parameters.new(
      { session: {email: user.email, password: user.password }
      })
    }
    it "redirects to pending subscriptions page" do
      post :admin_create, params: not_registered_user.to_unsafe_h
      expect(response).to redirect_to(admin_login_path)
    end

    it "calls Subscription.create_and_request_confirmation(params)" do
      post :admin_create, params: registered_user.to_unsafe_h
      expect(response).to redirect_to(admin_dashboard_index_path)
    end
  end
end
