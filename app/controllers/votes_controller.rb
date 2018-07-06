class VotesController < ApplicationController
  include SessionsHelper
  before_action :validate_session
  before_action :set_poll

  def create
    vote(http_params)
    render json: { message: "vote registered" }, status: :ok
  end

  private

  def set_poll
    @poll = VoteType.find_by(id: http_params).poll
    if @poll.nil?
      flash[:danger] = t('.poll_does_not_exist')
      redirect_to polls_path
    end
  end

  def vote(code)
    @poll.transaction do
      vote_type = VoteType.find_by(id: code)
      vote = current_user.votes.build(
        poll_id: @poll.id,
        vote_type: vote_type
      )
      return true if user_already_voted?(current_user, @poll)
      vote.save
    end
  rescue ActiveRecord::RecordInvalid
    error_msg = "#{I18n.t(:accion_no_realizada)} "
    error_msg += vote.errors.messages[:base].join(' ') unless vote.errors.messages[:base].nil?
    Rails.logger.debug(error_msg)
    flash[:danger] = "Tu voto no pudo ser registrado, intenta nuevamente"
    redirect_to polls_path
  end

  def http_params
    params[:vote][:vote_type_id].to_i
  end

  def user_already_voted?(user, poll)
    Vote.where('user_id = ? AND poll_id = ?', user.id, poll.id).present?
  end

end
