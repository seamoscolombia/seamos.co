class VotesController < ApplicationController
  include SessionsHelper
  before_action :validate_session, except: :check_vote
  before_action :set_poll, except: :check_vote

  def create
    vote(http_params)
  end

  def check_vote
    vote_exists = Vote.where('poll_id = ? AND user_id = ?',
                             params[:poll_id],
                             params[:user_id]).first.present?
    render json: {
      already_voted: vote_exists
    }, status: :ok
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
    Rails.logger.info('')
    vote_type = nil
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
    flash[:danger] = " #{error_msg}"
    redirect_to polls_path
  end

  def http_params
    params[:vote][:vote_type_id].to_i
  end

  def user_already_voted?(user, poll)
    Vote.where('user_id = ? AND poll_id = ?', user.id, poll.id).present?
  end

end
