class SessionsController < ApplicationController
  def create
    uid = request.env['omniauth.auth']['uid']
    session[:uid] = uid
    @usuario = Usuario.find_by(uid: uid)
    if (@usuario)
      redirect_to usuario_path(@usuario)
    else
      redirect_to new_usuario_path()
    end
  end
  def error

  end
end

