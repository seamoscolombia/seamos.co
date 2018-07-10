class VotesController < ApplicationController
  before_action :validate_session
  before_action :set_poll

  def create
    return true if @poll.voted_by_user?(current_user.id)
    vote_type = VoteType.by_name(params[:vote]).first
    vote = Vote.create( poll: @poll, vote_type: vote_type, user: current_user)
    flash[:success] = "Tu voto ha sido registrado con éxito"
    redirect_to :back
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "Tu voto no pudo ser registrado, intenta nuevamente mas tarde"
    redirect_to root_path
  end

  private

  def set_poll
    @poll = Poll.find_by(id: params[:poll_id])
    unless @poll
      flash[:danger] = t('.poll_does_not_exist')
      redirect_to root_path
    end
  end
end
