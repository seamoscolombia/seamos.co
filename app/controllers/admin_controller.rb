class AdminController < ApplicationController
  include SessionsHelper
  before_action :validate_administrator

  def new
    @user = User.new()
    render :new
  end

  def create
      @user = User.new(user_params)

      if @user.save
        flash[:notice] = I18n.t(:accion_exitosa)
        redirect_to users_path
      else
        errs = @user.errors.map{ |k,v| "#{k}: #{v};   " }
        flash[:danger] = errs
        redirect_to new_admin_path @user
      end
  end

  # def index
  #   @users = filter_users_option
  #   @users_filter = params[:users_filter_select]
  # end


  private

    def validate_administrator
      puts "CURRENT USER: #{current_user}"
      if current_user.nil? || current_user.role_type != "administrador"
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(:first_surname, :second_surname, :names,
                                      :email, :password, :admin_photo,
                                      :password_confirmation, :role_type)
    end
end
