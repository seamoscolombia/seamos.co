module AdminHelper
  def admin_validator(usuario)
    usuario.role.code != 'administrador'
  end
end
