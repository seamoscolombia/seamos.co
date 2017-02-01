module SessionsHelper

  def current_user
    if session[:email]
      @current_user ||= Usuario.find_by(email: session[:email])
    else
      @current_user ||= Usuario.find_by(uid: session[:uid])
    end
  end

  def fb_image
    return session[:fb_image] || "https://cdns2.freepik.com/free-photo/super-simple-avatar_318-1018.jpg"
  end

  def is_admin?
    current_user && current_user.role.code == "administrador"
  end
end
