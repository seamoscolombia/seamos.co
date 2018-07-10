class FrontendController < ApplicationController
  def index
    @frontend_props = { name: "Stranger" }
    if current_user && (current_user.administrador? || current_user.politico? )
      redirect_to admin_dasboard_index_path
    end
  end
end
