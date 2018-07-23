class PrehomeController < ApplicationController
  before_action :redirect_admin_or_politician, only: :index
  
  def index
  end

  private

  def redirect_admin_or_politician
    if current_user && (current_user.administrador? || current_user.politico? )
      redirect_to admin_dashboard_index_path
    end
  end
end
