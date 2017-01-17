class DebatesController < ApplicationController
  def new
  end
  before_action :get_poll,

  def create
  end

  def destroy
  end

  def index
  end

  def show
  end
  private
    def get_poll
      @poll = Poll.find_by(id: params[:poll_id])
    end
end
