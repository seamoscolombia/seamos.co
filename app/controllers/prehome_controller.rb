class PrehomeController < ApplicationController
  def index
    if current_user && (current_user.administrador? || current_user.politico? )
      redirect_to admin_homepage_path
    end
  end
end
