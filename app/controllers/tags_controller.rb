class TagsController < ApplicationController
  before_action :set_tag, only: :show
  before_action :set_random_polls, only: :index

  def index
    @location_from = ''
    # @tags = Tag.joins(:polls).where(polls: {active: true}).uniq //use this when there are tags with polls
    @tags = Tag.all
  end

  def show
    @polls = @tag.polls.active.includes([:votes, :user])
    @discussions = ForumThread.last(30)
  end

  private

  def set_tag
    @tag = Tag.find_by(id: params[:id])
    unless @tag
      flash[:error] = "El tema no existe"
      redirect_to root_path
    end
  end
end
