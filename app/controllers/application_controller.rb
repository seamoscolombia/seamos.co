class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  def validate_session    
    redirect_to root_path if current_user.nil?
  end
  
  def validate_superadmin
    unless current_user && current_user.role_type == 'administrador'
      flash[:error] = "Primero debes acceder como administrador"
      redirect_to root_path 
    end
  end

  def validate_politician
    unless current_user && current_user.role_type == 'politico'
      flash[:error] = "Primero debes acceder como político"
      redirect_to root_path 
    end
  end

  def validate_admin_or_politician
    unless current_user && (current_user.role_type == 'politico' || current_user.role_type == 'administrador')
      flash[:error] = "No estás autorizado para realizar esta acción"
      redirect_to root_path 
    end
  end

  def set_random_polls
    active_polls = Poll.includes(:votes, :tags).open
    closed_polls = Poll.includes(:votes, :tags).closed
    @random_polls = active_polls.first(4)
    @random_polls << closed_polls.shuffle.first(4 - @random_polls.size)
    @random_polls = @random_polls.flatten.first(4) if @random_polls.present?
  end
end
