class VotesController < ApplicationController
  before_action :validate_session
  before_action :set_poll
  before_action :set_vote_type

  def create
    return true if @poll.voted_by_user?(current_user.id)
    vote = Vote.new( poll: @poll, vote_type: @vote_type, user: current_user)
    if vote.save
      flash[:success] = "Tu voto ha sido registrado con éxito"
      redirect_to :back
    else
      flash[:danger] = "Tu voto no pudo ser registrado, intenta nuevamente mas tarde"
      redirect_to root_path
    end
  end

  private

  def set_poll
    @poll = Poll.find_by(id: params[:poll_id])
    unless @poll
      flash[:danger] = t('.poll_does_not_exist')
      redirect_to root_path
    end
  end

  def set_vote_type
    ensure_valid_vote_type
    @vote_type = @poll.vote_types.where(name: params[:vote]).first_or_create do |vote|
      vote.name = params[:vote]
    end
  end

  def ensure_valid_vote_type
    unless params[:vote] == 'SI' || params[:vote] == 'NO'
      flash[:error] = "Tipo de voto no válido"
      redirect_to root_path
    end
  end
end
