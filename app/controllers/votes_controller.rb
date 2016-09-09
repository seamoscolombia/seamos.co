class VotesController < ApplicationController
  include SessionsHelper
  before_action :validate_session

  def yes
    vote = current_user.votes.build(
        poll_id: params[:vote][:poll_id],
        vote_type: VoteType.find_by(code: "yes")
    )
    vote_save vote
  end

  def no
    vote = current_user.votes.build(
        poll_id: params[:vote][:poll_id],
        vote_type: VoteType.find_by(code: "no")
    )
    vote_save vote
  end

  def blank
    vote = current_user.votes.build(
        poll_id: params[:vote][:poll_id],
        vote_type: VoteType.find_by(code: "blank")
    )
    vote_save vote
  end


  private
    def vote_save(vote) 
      if vote.save!
        redirect_to polls_path
      else
        redirect_to polls_path, danger: I18n.t(:accion_no_realizada)
      end
    end

end
