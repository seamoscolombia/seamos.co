module SessionsHelper
  def fb_image
    return current_user.admin_photo.present? ? current_user.admin_photo : "https://cdns2.freepik.com/free-photo/super-simple-avatar_318-1018.jpg"
  end

  def is_admin?
    current_user && current_user.role_type == "administrador"
  end
end
