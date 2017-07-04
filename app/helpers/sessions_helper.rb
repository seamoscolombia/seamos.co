module SessionsHelper

  def current_user
    if session[:email]
      @current_user ||= User.find_by(email: session[:email])
    elsif session[:uid]
      @current_user ||= User.find_by(uid: session[:uid])
    else
      nil
    end
  end

  def fb_image
    return current_user.admin_photo.present? ? current_user.admin_photo : "https://cdns2.freepik.com/free-photo/super-simple-avatar_318-1018.jpg"
  end

  def is_admin?
    current_user && current_user.role_type == "administrador"
  end
end
