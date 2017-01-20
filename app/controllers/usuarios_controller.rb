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

  def index
    @usuarios = Usuario.where("valido= ? and role_id!= ?", false,
        Role.find_by(code: "administrador")
    )
  end

  def show
  end

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

    @usuario.document_photo_id = params[:photo_id]
    respond_to do |format|
      format.html do
        if @usuario.save
          redirect_to polls_path, notice: I18n.t(:success)
        else
          render :new
        end
      end

      format.json do
        fecha_expedicion = Date.strptime(@usuario.fecha_expedicion, "%m/%d/%Y")
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
