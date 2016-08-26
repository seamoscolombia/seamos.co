class SessionsController < ApplicationController
  protect_from_forgery with: :exception, except: [:create]
  def create
    uid = (request.format.json?) ? params[:uid] : request.env['omniauth.auth']['uid']
    session[:uid] = uid
    @usuario = Usuario.find_by(uid: uid)
    respond_to do |format|
      if (@usuario)
        format.html { redirect_to usuario_path(@usuario)  }
        format.json { render json: {},status: :ok  }
      else
        format.html { redirect_to new_usuario_path() }
        format.json { render json: {},status: :not_found  }
      end
    end
  end
  def error

  end
end

