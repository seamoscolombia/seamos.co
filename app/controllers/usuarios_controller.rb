class UsuariosController < ApplicationController
  include SessionsHelper
  before_action :validate_session, only: :already_voted
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  before_action :validate_administrator, only: :index

  def already_voted
    render json: {
      already_voted: current_user.already_voted?(params[:id])
    }, status: :ok
  end

  def create
    @usuario = Usuario.new(usuario_params)
    @usuario.valido = false
    @usuario.role = Role.find_by(code: 'ciudadano')
    @usuario.uid = session[:uid]

    @usuario.document_photo_id = params[:photo_id]
    @usuario.email = params[:usuario_email]
    respond_to do |format|
      format.html do
        if @usuario.save
          redirect_to polls_path, notice: I18n.t(:success)
        else
          render :new
        end
      end

      format.json do
        # server Date format 2015-05-28 YYYY-MM-DD
        Rails.logger.debug("@usuario.fecha_expedicion.to_s #{@usuario.fecha_expedicion.to_s}")
        Rails.logger.debug("Time.parse(@usuario.fecha_expedicion.to_s #{Time.parse(@usuario.fecha_expedicion.to_s)}")
        Rails.logger.debug("Time.parse(@usuario.fecha_expedicion.to_s).strftime("%Y-%m-%d") #{Time.parse(@usuario.fecha_expedicion.to_s).strftime("%Y-%m-%d")}")
        fecha_expedicion = Time.parse(@usuario.fecha_expedicion.to_s).strftime("%Y-%m-%d")
        @usuario.fecha_expedicion = fecha_expedicion
        if @usuario.save
          render :show, status: :created, location: usuarios_url(@usuario)
        else
          logger.debug "Create User Error: #{@usuario.errors.messages}"
          render json: @usuario.errors.messages.map { |message| { message[0].to_s.humanize => message[1] } }.first, status: :unprocessable_entity
        end
      end
    end

  end

  def edit
    usuario_exist
  end

  def index
    @usuarios = filter_usuarios_option
    @usuarios_filter = params[:usuarios_filter_select]
  end

  def new
    @usuario = Usuario.new()
  end

  def show
  end

  def update
    @usuario.transaction do
      document_photo_param = params[:usuario][:document_photo]
      @usuario = Usuario.find_by(id: params[:id])
      @usuario.attributes = usuario_params
      if document_photo_param
        @usuario.document_photo.delete
        document_photo = DocumentPhoto.create!(url: document_photo_param);
        @usuario.document_photo = document_photo
      end
      @usuario.save!
    end
    flash[:notice] = I18n.t(:accion_exitosa)
    redirect_to usuarios_path
  rescue ActiveRecord::RecordInvalid => e
    puts "update usuario: #{e}"
    flash[:danger] = " #{e}"
    redirect_to edit_usuario_path @usuario
  end

  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html {
        redirect_to usuarios_url, notice: I18n.t(:success) }
      format.json { head :no_content }
    end
  end

  def validate
    usuario_exist
  end

  def update_valid_usuario
    if @usuario.update({valido: true})
      redirect_to usuarios_path, notice: I18n.t(:success)
    end
  end

  private
    def filter_usuarios_option
      case params[:usuarios_filter_select]
        when "1"
          Usuario.all.page(params[:page]).per(4)
        when "0"
          Usuario
           .where("valido= ? and role_id!= ?",
             false,
             Role.find_by(code: "administrador")
           ).page(params[:page]).per(4)
        else
          Usuario.where("valido= ? and role_id!= ?",
            false,
            Role.find_by(code: "administrador")
          ).page(params[:page]).per(4)
      end
    end

    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    def usuario_params
      params.require(:usuario).permit(:primer_apellido, :segundo_apellido, :nombres,
                                      :tipo_de_documento_id, :numero_documento,
                                      :fecha_expedicion, :email, :password, :password_confirmation)
    end

    def usuario_exist
      @usuario = Usuario.find_by(id: params[:id])
      redirect_to usuarios_path if @usuario.nil?
    end
    def validate_administrator
      if current_user.nil? || current_user.role.code != "administrador"
        redirect_to root_path
      end
    end
end
