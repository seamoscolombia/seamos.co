class SubscriptionsController < ApplicationController

  protect_from_forgery except: :create
  before_action :validate_admin_user, only: :destroy

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      @unsubscribe = Rails.application.message_verifier(:unsubscribe).generate(@subscription.id)
      UserNotifierMailer.send_subscription_email(@subscription.email, @unsubscribe).deliver_later
      flash[:success] = "Tu email #{@subscription.email} ha quedado suscrito"
    else
      flash[:error] = "Tu email #{@subscription.email} no fue suscrito debido a: #{@subscription.errors.messages[:email].to_sentence}"
    end
    redirect_to root_path
  end

  def destroy
    @subscription = Subscription.find_by(id: params[:id])
    @subscription.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def validate_admin_user
    redirect_to :root unless current_user && current_user.role_type = 'administrador'
  end

  def subscription_params
    params.require(:subscription).permit(:email)
  end
end
