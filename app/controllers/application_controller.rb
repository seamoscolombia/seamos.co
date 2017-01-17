class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def validate_session
    if current_user.nil?
      respond_to do |format|
       format.html { redirect_to root_path }
       format.json { render json: {}, status: :unauthorized }
     end 
    end
  end
end
