class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  include SessionsHelper

  def validate_session
    if current_user.nil?
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: {}, status: :unauthorized }
      end
    end
  end
  def validate_superadmin
    redirect_to :root unless current_user && current_user.role_type = 'administrador'
  end
end
