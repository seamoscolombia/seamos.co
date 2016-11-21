class UsuariosController < ApplicationController
  include SessionsHelper
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  before_action :validate_administrator, only: :index

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.where(valido: false)
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new()
  end

  def edit
    @usuario = Usuario.find_by(id: params[:id])
    redirect_to usuarios_path if @usuario.nil?
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params)
    @usuario.valido = false
    @usuario.role = Role.find_by(code: 'ciudadano')
    @usuario.uid = session[:uid]
    respond_to do |format|
      @usuario.document_photo_id = params[:photo_id]
      if @usuario.save
        format.html { redirect_to polls_path, notice: I18n.t(:success) }
        format.json { render :show, status: :created, location: usuarios_url(@usuario) }
      else
        format.html { render :new }
        format.json { render json: @usuario.errors.messages.map { |message| { message[0].to_s.humanize => message[1] } }.first, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @usuario.update({valido: true})
      redirect_to usuarios_url, notice: I18n.t(:success)
    end
  end

  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: I18n.t(:success) }
      format.json { head :no_content }
    end
  end

  private
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    def usuario_params
      params.require(:usuario).permit(:primer_apellido, :segundo_apellido, :nombres,
                                      :tipo_de_documento_id, :numero_documento,
                                      :fecha_expedicion)
    end
    def validate_administrator
      if current_user.role.code != "administrador"
        redirect_to root_path
      end
    end
end
