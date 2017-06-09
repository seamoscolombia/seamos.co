module AdminHelper
  def admin_validator(user)
    user.role_type != 'administrador'
  end
end
