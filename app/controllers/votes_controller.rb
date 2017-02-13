class VotesController < ApplicationController
  include SessionsHelper
  before_action :validate_session
  before_action :set_poll

  def create
    vote(http_params)
  end

  private

    def publish_vote_facebook(vote)
      user_graph = Koala::Facebook::API.new(session[:fb_token])
      link_url = polls_url+"##{vote.poll.id}" if Rails.env.production?

      user_graph.put_connections( "me", "feed", message: vote.poll.title, link: link_url)
    end

    def set_poll
      @poll = VoteType.find_by(id: http_params).poll
      if @poll.nil?
        flash[:danger] = t(".poll_does_not_exist")
        redirect_to polls_path
      end
    end

    def vote(code)
      Rails.logger("")
      vote_type = nil
      @poll.transaction do
      vote_type = VoteType.find_by(id: code)
      if @poll.private?
        totals = eval(@poll.totals)
        totals[vote_type.id] += 1
        @poll.totals = totals
        @poll.save!
        vote = current_user.votes.build( poll_id: @poll.id )
      else
        vote = current_user.votes.build(
            poll_id: @poll.id,
            vote_type: vote_type
        )
      end
        vote_save_fb vote
      end
    rescue ActiveRecord::RecordInvalid
      error_msg = "#{I18n.t(:accion_no_realizada)} "
      error_msg += vote.errors.messages[:base].join(" ") unless vote.errors.messages[:base].nil?
      Rails.logger(error_msg)
      flash[:danger] = " #{error_msg}"
      redirect_to polls_path
    end

    def http_params
      params[:vote][:vote_type_id].to_i
    end

    def vote_save_fb(vote)
      if vote.save!
        # publish_vote_facebook vote if params["vote"]["fb_feed"] == "true"
        redirect_to polls_url #+"##{vote.poll.id}"
      end
    end

end
