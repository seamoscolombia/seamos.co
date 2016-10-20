class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def validate_session
    if current_user.nil?
      redirect_to root_path
    end
  end
end
