class Admin::UsersController < ApplicationController
  before_action :set_user, except: :index
  before_action :validate_superadmin
  before_action :authenticate_user!

  def edit
  end

  def index
    @users = User.all.page(params[:page]).per(4)
    @users = @users.by_role_type(params[:users_filter_select]).page(params[:page]).per(4) if params[:users_filter_select] && params[:users_filter_select] != ''
    @users = @users.search(params[:search_term]).page(params[:page]).per(4) unless params[:search_term].blank?
  end

  def update
    @user.transaction do
      @user.attributes = user_params.except(:major_electoral_representation_localities)
      localities_string = params[:user][:major_electoral_representation_localities].reject { |l| l.empty? }.join(', ') unless params[:user][:major_electoral_representation_localities].blank?
      @user.major_electoral_representation_localities = localities_string unless localities_string.blank?
      @user.save!
      flash[:notice] = I18n.t(:accion_exitosa)
      redirect_to admin_users_path
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = " #{e}"
    redirect_to edit_users_path @user
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: I18n.t(:success)
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = "El usuario no existe"
      redirect_to admin_users_path 
    end
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
end