class DebateVotesController < ApplicationController
  include SessionsHelper
  before_action :validate_session
  before_action :set_debate

  def create
    vote(http_params)
  end

  private
    def set_debate
      @debate = Question.find_by(id: http_params).debate
      if @debate.nil?
        flash[:danger] = t(".debates_does_not_exist")
        redirect_to poll_debates_path
      end
    end

    def vote(question_id)
      question = nil
      @debate.transaction do
        question = Question.find_by(id: question_id)
        debate_vote = current_user.debate_votes.build(
            debate_id: @debate.id,
            question: question
        )
        # debate_vote.save!
        respond_to do |format|
          format.json { render json: { status: :created },status: :created }
        end
      end
    rescue ActiveRecord::RecordInvalid
      error_msg = "#{I18n.t(:accion_no_realizada)} "
      error_msg += debate_vote.errors.messages[:base].join(" ") unless vote.errors.messages[:base].nil?
      flash[:danger] = " #{error_msg}"
      puts error_msg
      respond_to do |format|
        format.html { redirect_to polls_path }
        format.json { render json: { error: error_msg }, status: :bad_request }
      end
    end

    def http_params
      params[:debate_vote][:question_id].to_i
    end

end
