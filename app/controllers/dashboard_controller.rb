class DashboardController < ApplicationController
  before_action :validate_session
  before_action :validate_admin_user

  def index
  end

  private
    def validate_admin_user
       unless current_user.role.code == "administrador"
         redirect_to root_path
       end
    end
end
