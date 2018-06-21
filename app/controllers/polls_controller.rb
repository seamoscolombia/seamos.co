class PollsController < ApplicationController
  include SessionsHelper
  before_action :validate_poll_closed?, only: :show
  
  before_action :validate_session, except: [:index,
                                            :show,
                                            :client_show,
                                            :filtered_by_tag,
                                            :summary_polls]
 
  before_action :set_tag, only: :filtered_by_tag
  before_action :set_poll, only: :client_show


  def summary_polls
    @polls = Poll.includes(:votes, :tags).order(created_at: :desc).limit(40)
  end

  
  def show
    @poll = Poll.find_by(id: params[:id])
    respond_to do |format|
      format.html do
        chart_type = 'pie'
        if params[:poll].nil? || (params[:poll][:initial_date].empty? && params[:poll][:final_date].empty?)
          @vote_types = @poll.votes.joins(:vote_type)
          .group('vote_types.name')
          .count('vote_types.id')
        else
          i_date = params[:poll][:initial_date]
          f_date = params[:poll][:final_date]
          @vote_types = @poll.votes.joins(:vote_type).where(created_at: i_date...f_date)
          @vote_types = @vote_types.group('vote_types.name').count('vote_types.id') unless @vote_types.empty?
        end
        puts "@vote_types: #{@vote_types}"
      end
      format.json do
        @vote_types = @poll.votes.joins(:vote_type)
        .group('vote_types.name')
        .count('vote_types.id')
      end
    end
  end

  def voted
    @polls = current_user.voted_polls.last(5)
    respond_to do |format|
      format.html { @polls }
      format.json { @polls }
    end
  end

  private
    def set_poll
      @poll = Poll.find_by(id: params[:id])
    end

    def set_tag
      @tag = Tag.find_by(id: params[:tag_id])
    end

    def validate_poll_closed?
      poll = Poll.find_by(id: params[:id])
      unless poll
        respond_to do |format|
          format.html { redirect_to polls_path }
          format.json { render json: { errors: '404' }, status: :not_found }
        end
      end
    end    
end
