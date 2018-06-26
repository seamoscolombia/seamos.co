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
  end
end
