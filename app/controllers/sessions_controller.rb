class SessionsController < ApplicationController
  protect_from_forgery with: :exception, except: [:create]

  def create
    if request.format.json?
      uid = params[:uid]
    else
      uid = request.env['omniauth.auth']['uid']
      session[:fb_token] = request.env['omniauth.auth']['credentials']['token']
    end
    session[:uid] = uid
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

