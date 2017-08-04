class VotesController < ApplicationController
  include SessionsHelper
  before_action :validate_session
  before_action :set_poll

  def create
    vote(http_params)
  end

  private

  # def publish_vote_facebook(vote)
  #   users_graph = Koala::Facebook::API.new(session[:fb_token])
  #   link_url = polls_url + "##{vote.poll.id}" if Rails.env.production?
  #
  #   users_graph.put_connections('me', 'feed', message: vote.poll.title, link: link_url)
  # end

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
      redirect_to polls_url if user_already_voted?(current_user, @poll)
      vote_save_fb vote
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

  def vote_save_fb(vote)
    if vote.save!
      # publish_vote_facebook vote if params["vote"]["fb_feed"] == "true"
      redirect_to polls_url #+"##{vote.poll.id}"
    end
  end
end
