class SuscriptionsController < ApplicationController

  protect_from_forgery except: :create

  def create
    @suscription = Suscription.new(subscription_params)
    if @suscription.save
      render json: {
        message: "Tu email #{@suscription.email} ha quedado suscrito",
        success: true
      }, status: 201
    else
      render json: {
        errors: @suscription.errors.messages[:email],
        success: false
      }
    end
  end

  def subscription_params
    params.require(:subscription).permit(:email)
  end
end
