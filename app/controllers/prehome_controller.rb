class PrehomeController < ApplicationController
  before_action :validate_user, only: :index
  
  def index
  end

  def validate_user 
    if current_user && (current_user.administrador? || current_user.politico? )
      redirect_to admin_homepage_path
    end
  end
end
