class EmailListsController < ApplicationController
  before_action :email_list_params, only: :set_email_lists
  before_action :validate_superadmin

  def new
    @email_list = EmailList.new
  end

  def index
    @email_lists = EmailList.all
  end

  def create
    @email_list = EmailList.new(email_list_params)
    if @email_list.save
      begin
        @email_list.create_subscriptions(email_list_params[:raw_mail_list])
      rescue
        flash[:error] = "La lista no pudo ser creada"
      end
      flash[:success] = "lista creada con éxito"
      redirect_to admin_email_lists_path and return
    else
      flash[:error] = "La lista no pudo ser creada"
      render :new and return
    end
  end

  def destroy
    @email_list = EmailList.find_by(id: params[:id])
    @email_list.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def email_list_params
    params.require(:email_list).permit(:name, :raw_mail_list)
  end
end
