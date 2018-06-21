class UsersController < ApplicationController
  include SessionsHelper
  before_action :validate_session, only: :already_voted
  before_action :set_user, only: [:edit, :update, :destroy, :politician_profile]
  before_action :authenticate_user!
  before_action :set_random_polls, only: :show

  def show
    if current_user
      @user = current_user
      @tags = @user.tags
      @participations = @user.votes.map(&:poll)
    else
      render :json => { errors: t(".not_logged_in") }, status: 401
    end
  end
end
