module SessionsHelper
  def current_user
    @current_user ||= Usuario.find_by(uid: session[:uid])
  end

  def is_admin?
    current_user.role.code == "administrador"
  end
end
