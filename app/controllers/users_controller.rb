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
    @user = User.new(users_params)
    @user.approved = false
    @user.role_type = 0
    @user.uid = session[:uid]

    @user.email = params[:users_email]
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
    users_exist
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
      @user = User.find_by(id: params[:id])
      @user.attributes = users_params
      @user.save!
    end
    flash[:notice] = I18n.t(:accion_exitosa)
    redirect_to users_path
  rescue ActiveRecord::RecordInvalid => e
    puts "update user: #{e}"
    flash[:danger] = " #{e}"
    redirect_to edit_users_path @user
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
    users_exist
  end

  def update_valid_user
    if @user.update(approved: true)
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
        .where('approved= ? and role_type!= ?', false, 2)
        .page(params[:page]).per(4)
    else
      User
        .where('approved= ? and role_type!= ?', false, 2)
        .page(params[:page]).per(4)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:first_surname, :second_surname, :names,
                                    :tipo_de_documento_id, :document_number,
                                    :expedition_date, :email, :password, :password_confirmation)
  end

  def users_exist
    @user = User.find_by(id: params[:id])
    redirect_to users_path if @user.nil?
  end

  def validate_administrator
    if current_user.nil? || current_user.role_type != 'administrador'
      redirect_to root_path
    end
  end
end
