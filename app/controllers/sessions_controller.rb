class SessionsController < ApplicationController
  protect_from_forgery with: :exception, except: [:create, :destroy, :destroy_facebook_session]
  include SessionsHelper

  def admin_create
    user = User.get_admin(http_params)
    if user
      session[:session_type] = 'web'
      session[:email] = user.email
      redirect_to admin_dashboard_index_path
    else
      flash[:warning] = I18n.t(:admin_invalid)
      redirect_to admin_login_path
    end
  end

  def show
    render json: { session_initiated: current_user.present?,
                   authenticity_token: form_authenticity_token
                 }, status: :ok
  end

  def error
  end

  def new
    if current_user && current_user.administrador?
      redirect_to admin_dashboard_index_path
    end
  end

  private
    def http_params
      params[:session].permit(:email, :password)
    end
end
