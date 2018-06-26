class Admin::UsersController < ApplicationController
  before_action :validate_session, only: :already_voted
  before_action :set_user, only: [:edit, :update, :destroy, :politician_profile]
  before_action :validate_superadmin, only: %i(new delete)
  before_action :authenticate_user!

  def create
    respond_to do |format|
      format.json do
        @user = User.new(user_params)
        @user.approved = false
        @user.role_type = 0
        @user.uid = session[:uid]
        # server Date format 2015-05-28 YYYY-MM-DD
        if @user.save
          @participations = Poll.get_user_participations(@user)
          render :show, status: :created, location: users_url(@user)
        else
          logger.debug "Create User Error: #{@user.errors.messages}"
          errors = @user.errors.messages.map { |message| { message[0].to_s.humanize => message[1] } } || []
          render json: { errors: errors }, status: :unprocessable_entity
        end
      end
      format.html do
        @user = User.new(user_params.except(:major_electoral_representation_localities))
        localities_string = localities_array_to_string(params[:user][:major_electoral_representation_localities]) unless params[:user][:major_electoral_representation_localities].blank?
        @user.major_electoral_representation_localities = localities_string
        if @user.save
          flash[:notice] = I18n.t(:accion_exitosa)
          redirect_to users_path
        else
          errs = @user.errors.map{ |k,v| flash[:danger] = "#{k}-#{v}" }
          redirect_to new_admin_path @user
        end
      end
    end
  end

  def edit
    users_exist
  end

  def index
    @users = User.all.page(params[:page]).per(4)
    @users = @users.by_role_type(params[:users_filter_select]).page(params[:page]).per(4) if params[:users_filter_select] && params[:users_filter_select] != ''
    @users = @users.search(params[:search_term]).page(params[:page]).per(4) unless params[:search_term].blank?
  end

  def new
    @user = User.new
  end

  def show
    if current_user
      @user = current_user
      @participations = @user.votes.map(&:poll)
    else
      render :json => { errors: t(".not_logged_in") }, status: 401
    end
  end

  def update
    @user.transaction do
      @user = User.find_by(id: params[:id])
      @user.attributes = user_params.except(:major_electoral_representation_localities)
      localities_string = localities_array_to_string(params[:user][:major_electoral_representation_localities]) unless params[:user][:major_electoral_representation_localities].blank?
      @user.major_electoral_representation_localities = localities_string unless localities_string.blank?
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

  private

  def localities_array_to_string(localities_array)
    localities = []
    localities_array.delete("")
    localities_array.each do |res|
      localities << res
    end
    localities.join(", ")
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_surname,
                                 :second_surname,
                                 :names,
                                 :email,
                                 :password,
                                 :admin_photo,
                                 :password_confirmation,
                                 :role_type,
                                 :bio,
                                 :organization,
                                 :birthday,
                                 :birthplace,
                                 :last_election_vote_count,
                                 :represented_organizations,
                                 :major_electoral_representation_localities,
                                 :other_periods_elected,
                                 :current_corporation_commission,
                                 :proposed_initiatives_to_date,
                                 :twitter_username,
                                 academic_titles_attributes: [:id,
                                                              :title,
                                                              :period,
                                                              :annotation,
                                                              :institute,
                                                              :_destroy]
                                )
  end

  def users_exist
    @user = User.find_by(id: params[:id])
    redirect_to users_path if @user.nil?
  end
end