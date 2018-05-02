class MessagesController < ApplicationController
  before_action :fetch_message, only: :preview
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      UserNotifierMailer.send_general_message(message_params).deliver_later
      flash[:notice] = "Mensaje enviado correctamente"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def preview
    @message = {subject: params[:subject], content: params[:content], user_name: 'Celia cruz'}
    render 'user_notifier_mailer/send_general_message'
  end

  private

  def fetch_message
    @message = params[:message]
  end

  def message_params
    params.require(:message).permit(params[:message].keys).to_h
  end
end