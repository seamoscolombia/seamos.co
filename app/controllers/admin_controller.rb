class AdminController < ApplicationController
  include SessionsHelper
  before_action :validate_administrator

  def new
    @user = User.new()
    render :new
  end

  def create
    @user = User.new(user_params.except(:major_electoral_representation_localities))
    localities_string = localities_array_to_string(params[:user][:major_electoral_representation_localities]) unless params[:user][:major_electoral_representation_localities].blank?
    @user.major_electoral_representation_localities = localities_string
    if @user.save
      flash[:notice] = I18n.t(:accion_exitosa)
      redirect_to users_path
    else
      errs = @user.errors.map{ |k,v|  "#{k}: #{v}" }
      flash[:danger] = errs
      redirect_to new_admin_path @user
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    redirect_to users_path if @user.nil?
  end

  def update
    @user.transaction do
      @user.attributes = user_params.except(:major_electoral_representation_localities)
      localities_string = localities_array_to_string(params[:user][:major_electoral_representation_localities]) unless params[:user][:major_electoral_representation_localities].blank?
      @user.major_electoral_representation_localities = localities_string
      @user.save!
    end
    flash[:notice] = I18n.t(:accion_exitosa)
    redirect_to users_path
  rescue ActiveRecord::RecordInvalid => e
    puts "update user: #{e}"
    flash[:danger] = " #{e}"
    redirect_to edit_users_path @user
  end

  # def index
  #   @users = filter_users_option
  #   @users_filter = params[:users_filter_select]
  # end


  private

    def localities_array_to_string(localities_array)
      localities = []
      localities_array.delete("")
      localities_array.each do |res|
        localities << res
      end
      localities.join(", ")
    end

    def validate_administrator
      puts "CURRENT USER: #{current_user}"
      if current_user.nil? || current_user.role_type != "administrador"
        redirect_to root_path
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
                                   :profession,
                                   :university,
                                   :further_studies,
                                   :last_election_vote_count,
                                   :represented_organizations,
                                   :major_electoral_representation_localities,
                                   :other_periods_elected,
                                   :current_corporation_commission,
                                   :proposed_initiatives_to_date
                                  )
    end
end
