# == Schema Information
#
# Table name: debates
#
#  id         :integer          not null, primary key
#  title      :string
#  published  :boolean          default(FALSE)
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DebatesController < ApplicationController
  before_action :validate_session
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
    @debate = Debate.new(http_params)
    @debate.usuario = Usuario.find_by(uid: params[:debate][:usuario_uid])
    if @debate.save
      redirect_to poll_debates_path @debate.poll
    else
      @poll = Poll.find_by(id: params[:poll_id])
      render :new
    end
  end

  def destroy
  end

  def edit
    @debate = Debate.find_by(id: params[:id])
    @questions = @debate.questions
  end

  def index
    respond_to do |format|
      format.html {
        @debates = Debate.where(poll_id: @poll.id)
      }
      format.json {
        @debates = Debate.where('poll_id= ? AND published= ?', @poll.id, true)
      }
    end
  end

  def publish
    debate = Debate.find_by(id: params[:id])
    debate.published = !debate.published
    if debate.save
      redirect_to poll_debates_path debate.poll
    else
      redirect_to edit_poll_debate_path debate
    end
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
        :uid,
        {questions_attributes: [:description]}
      )
    end
end
