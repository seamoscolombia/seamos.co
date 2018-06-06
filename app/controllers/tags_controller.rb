class TagsController < ApplicationController
  before_action :set_user, only: :user_interests

  def index
    respond_to do |format|
      format.html do
        @location_from = ''
        @tags = Tag.all
      end
      format.json do
        @tags = Tag.all
      end
    end
  end

  def user_interests
    respond_to do |format|
      format.json do
        @tags = Tag.all
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
