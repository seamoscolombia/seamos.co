class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :store_user_location!, if: :storable_location?
  protect_from_forgery with: :reset_session, prepend: true

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

  def after_sign_in_path_for(resource_or_scope)
    return admin_dashboard_index_path if admin_or_politician?(current_user)
    stored_location_for(resource_or_scope) || super
  end

  private

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
