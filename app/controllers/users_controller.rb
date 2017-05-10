class UsersController < ApplicationController
  include SessionsHelper
  before_action :validate_session, only: :already_voted
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :validate_administrator, only: :index

  def already_voted
    render json: {
      already_voted: current_user.already_voted?(params[:id])
    }, status: :ok
  end

  def create
    @user = User.new(user_params)
    @user.valido = false
    @user.role_type = 0
    @user.uid = session[:uid]

    @user.document_photo_id = params[:photo_id]
    @user.email = params[:user_email]
    respond_to do |format|

      format.json do
        # server Date format 2015-05-28 YYYY-MM-DD
        if @user.save
          render :show, status: :created, location: users_url(@user)
        else
          logger.debug "Create User Error: #{@user.errors.messages}"
          errors = @user.errors.messages.map { |message| { message[0].to_s.humanize => message[1] } } || []
          render json: { errors: errors }, status: :unprocessable_entity
        end
      end
    end
  end

  def edit
    user_exist
  end

  def index
    @users = filter_users_option
    @users_filter = params[:users_filter_select]
  end

  def new
    @user = User.new
  end

  def show
  end

  def update
    @user.transaction do
      document_photo_param = params[:user][:document_photo]
      @user = User.find_by(id: params[:id])
      @user.attributes = user_params
      if document_photo_param
        @user.document_photo.delete
        document_photo = DocumentPhoto.create!(url: document_photo_param)
        @user.document_photo = document_photo
      end
      @user.save!
    end
    flash[:notice] = I18n.t(:accion_exitosa)
    redirect_to users_path
  rescue ActiveRecord::RecordInvalid => e
    puts "update user: #{e}"
    flash[:danger] = " #{e}"
    redirect_to edit_user_path @user
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        redirect_to users_url, notice: I18n.t(:success)
      end
      format.json { head :no_content }
    end
  end

  def validate
    user_exist
  end

  def update_valid_user
    if @user.update(valido: true)
      redirect_to users_path, notice: I18n.t(:success)
    end
  end

  private

  def filter_users_option
    case params[:users_filter_select]
    when '1'
      User.all.page(params[:page]).per(4)
    when '0'
      User
        .where('valido= ? and role_type!= ?', false, 2)
        .page(params[:page]).per(4)
    else
      User
        .where('valido= ? and role_type!= ?', false, 2)
        .page(params[:page]).per(4)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_surname, :segundo_apellido, :nombres,
                                    :tipo_de_documento_id, :numero_documento,
                                    :fecha_expedicion, :email, :password, :password_confirmation)
  end

  def user_exist
    @user = User.find_by(id: params[:id])
    redirect_to users_path if @user.nil?
  end

  def validate_administrator
    if current_user.nil? || current_user.role_type != 'administrador'
      redirect_to root_path
    end
  end
end
