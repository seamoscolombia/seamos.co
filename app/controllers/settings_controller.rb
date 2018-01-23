class SettingsController < ApplicationController
  def unsubscribe
    @subscription_id = Rails.application.message_verifier(:unsubscribe).verify(params[:id])
    @subscription = Subscription.find(@subscription_id)
  end

  def update
    @subscription = Subscription.find(params[:id])
    email = @subscription.email
    if @subscription.destroy
      redirect_to settings_successfully_unsubscribed_path(email: email)
    else
      flash[:alert] = 'Hubo un problema, intentalo de nuevo más tarde'
      render :unsubscribe
    end
  end

  def successfully_unsubscribed
  end

  private
    def user_params
      params.require(:subscription).permit(:subscription)
    end
end
