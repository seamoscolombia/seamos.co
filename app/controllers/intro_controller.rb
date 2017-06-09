class IntroController < ApplicationController
  include SessionsHelper
  def inicio
  end

  def index
    if current_user
      redirect_to admin_dashboard_index_path
    end
  end
end
