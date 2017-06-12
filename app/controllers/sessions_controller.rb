class SessionsController < ApplicationController
  protect_from_forgery with: :exception, except: [:create]
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

  def create
    if request.format.json?
      uid = params[:uid]
      session[:fb_token] = params[:fb_token]
      session[:session_type] = "mobile"
    else
      puts  request.env['omniauth.auth']
      uid = request.env['omniauth.auth']['uid']
      session[:fb_token] = request.env['omniauth.auth']['credentials']['token']
      session[:fb_image] = request.env['omniauth.auth']['info']['image']
      session[:session_type] = "web"
    end
    session[:uid] = uid
    @user = User.find_by(uid: uid)
    respond_to do |format|
      if (@user)
        format.html do
          if session[:session_type] == 'web' && is_admin?
            redirect_to admin_dashboard_index_path
          elsif session[:session_type] == 'mobile'
            redirect_to polls_path
          else
            destroy
          end
        end
        format.json { render json: { authenticity_token: form_authenticity_token },status: :ok }
      else
        format.html { redirect_to root_path }
        format.json { render json: { authenticity_token: form_authenticity_token },status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session[:email] = session[:uid] = session[:fb_token] = session[:fb_image] = session[:session_type] = nil
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: {} , stats: :ok }
    end
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
