class DebatesController < ApplicationController
  before_action :get_poll,

  def create
    
  end

  def destroy
  end

  def index
  end

  def new
    @debate = Debate.new(poll_id: @poll.id)
  end

  def show
  end
  private
    def get_poll
      @poll = Poll.find_by(id: params[:poll_id])
    end
end
