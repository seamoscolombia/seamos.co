class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions, only: [:edit, :update]
  before_action :validate_admin_or_politician, only: [:edit, :update]
  before_action :validate_superadmin, except: [:edit, :update]
  before_action :set_user, except: [:index, :permits]
  before_action :search_users, only: [:index, :permits]

  def edit
    3.times { @user.academic_titles << AcademicTitle.new } unless @user.academic_titles.present?
  end

  def permits
  end

  def update
    @user.attributes = user_params.except(:major_electoral_representation_localities)
    localities_string = params[:user][:major_electoral_representation_localities].reject { |l| l.empty? }.join(', ') unless params[:user][:major_electoral_representation_localities].blank?
    @user.major_electoral_representation_localities = localities_string unless localities_string.blank?
    if @user.save
      flash[:notice] = "Información actualizada con éxito"
    else
      flash[:error] = @user.errors
    end
    redirect_to :back
  end

  def destroy
    @user.destroy
    redirect_to :back, notice: I18n.t(:success)
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = "El usuario no existe"
      redirect_to admin_users_path
    end
  end

  def search_users
    @users = User.all
    @users = @users.by_role_type(params[:users_filter_select]) unless params[:users_filter_select].blank?
    @users = @users.search(params[:search_term]) unless params[:search_term].blank?
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
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

  def check_permissions
    return true if current_user.administrador?
    unless current_user.politico? && params[:id].to_i == current_user.id
      flash[:error] = "Sólo puedes modificar tus propios datos"
      redirect_to root_path
    end
  end
end