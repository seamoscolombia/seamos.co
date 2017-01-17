class DebatesController < ApplicationController
  before_action :get_poll
  # { 
  #  "debate": {
  #     "title": "Debate 1",
  #     "poll_id": "5",
  #     "questions_attributes": {
  #       "0": {
  #         "description": "A"
  #       },
  #       "1": {
  #         "description":"B"
  #       }
  #     }
  #   },
  #   "poll_id":"5"
  # }
  def create
    Debate.create!(http_params)
    #ToDo if statement
  end

  def destroy
  end

  def index
    @debates = Debate.where(poll_id: @poll.id)
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

    def http_params
      params.require(:debate).permit(
        :title,
        :poll_id,
        {questions_attributes: [:description]}
      )
    end
end
