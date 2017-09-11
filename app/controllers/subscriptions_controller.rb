class SubscriptionsController < ApplicationController

  protect_from_forgery except: :create

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      render json: {
        message: "Tu email #{@subscription.email} ha quedado suscrito",
        success: true
      }, status: 201
    else
      render json: {
        message: "Ya te has suscrito previamente",
        success: false
      }
    end
  end

  def subscription_params
    params.require(:subscription).permit(:email)
  end
end
