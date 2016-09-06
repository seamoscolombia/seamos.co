class SessionsController < ApplicationController
  protect_from_forgery with: :exception, except: [:create]
  def create
    uid = (request.format.json?) ? params[:uid] : request.env['omniauth.auth']['uid']
    session[:uid] = uid
    session[:fb_token] = request.env['omniauth.auth']['credentials']['token']
    @usuario = Usuario.find_by(uid: uid)
    respond_to do |format|
      if (@usuario)
        format.html { redirect_to polls_path(@usuario)  }
        format.json { render json: { authenticity_token: form_authenticity_token },status: :ok  }
      else
        format.html { redirect_to new_usuario_path() }
        format.json { render json: { authenticity_token: form_authenticity_token },status: :not_found  }
      end
    end
  end
  def error

  end
end

