class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_random_polls, only: :show

  def show
    if current_user
      @user = current_user
      @tags = @user.tags
      @participations = @user.votes.map(&:poll)
      @interests = @user.interests
    else
      flash[:error] = t(".not_logged_in")
      redirect_to root_path
    end
  end
end
