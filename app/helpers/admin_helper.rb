module AdminHelper
  def admin_validator(usuario)
    usuario.role_type != 'administrador'
  end
end
