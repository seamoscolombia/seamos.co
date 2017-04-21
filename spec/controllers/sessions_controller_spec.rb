require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  context "POST create" do
    #Create new user
    let(:l_user) { FactoryGirl.create(:user) }
    #let(:l_user) { User.new(role_type: 0, uid: '', document_number: '') }

    #Params for a non registered user
    let (:not_registered_user) {ActionController::Parameters.new(
      { session: {email: "notuser@user.com", password: "password" }
      })
    }    
    #Params for a registered user
    let (:registered_user) {ActionController::Parameters.new(
      { session: {email: l_user.email, password: l_user.password }
      })
    }       
    it "redirects to pending subscriptions page" do
      post :admin_create, params: not_registered_user
      expect(response).to redirect_to(admin_login_path)
    end

    it "calls Subscription.create_and_request_confirmation(params)" do
      post :admin_create, params: registered_user
      expect(response).to redirect_to(dashboard_index_path)
    end
  end
end