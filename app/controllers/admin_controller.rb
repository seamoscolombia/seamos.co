class AdminController < ApplicationController
  include SessionsHelper
  before_action :validate_administrator

  def new
    @usuario = Usuario.new()
    render :new
  end

  def create
      @usuario = Usuario.new(usuario_params)
      document_photo_param = params[:usuario][:document_photo]
      document_photo = DocumentPhoto.create!(url: document_photo_param);
      @usuario.document_photo = document_photo
      @usuario.role = Role.find_by(code: 'administrador')

      if @usuario.save
        flash[:notice] = I18n.t(:accion_exitosa)
        redirect_to usuarios_path
      else
        errs = @usuario.errors.map{ |k,v| "#{k}: #{v};   " }
        flash[:danger] = errs
        redirect_to new_admin_path @usuario
      end
  end

  # def index
  #   @usuarios = filter_usuarios_option
  #   @usuarios_filter = params[:usuarios_filter_select]
  # end


  private

    def validate_administrator
      if current_user.nil? || current_user.role.code != "administrador"
        redirect_to root_path
      end
    end

    def usuario_params
      params.require(:usuario).permit(:primer_apellido, :segundo_apellido, :nombres,
                                      :tipo_de_documento_id, :numero_documento,
                                      :fecha_expedicion, :email, :password, :password_confirmation)
    end
end
