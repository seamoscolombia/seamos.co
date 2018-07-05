class MessagesController < ApplicationController
  before_action :validate_superadmin, only: %i(create new)

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      @recipients = EmailList.find_by(id: @message.email_list_id).subscriptions.pluck(:email)
      @recipients.each do |recipient|
        UserNotifierMailer.send_general_message(@message.sender, @message.subject, @message.top_image_url, @message.content, recipient).deliver_later        
      end
      flash[:notice] = "Mensaje enviado correctamente"
      redirect_to admin_mail_path
    else
      render :action => 'new'
    end
  end

  private

  def message_params
    params.require(:message).permit(params[:message].keys).to_h
  end
end