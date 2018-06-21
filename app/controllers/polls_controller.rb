class PollsController < ApplicationController
  include SessionsHelper
  before_action :validate_poll_closed?, only: :show
  
  before_action :validate_session, except: [:index,
                                            :show,
                                            :client_show,
                                            :filtered_by_politician,
                                            :filtered_by_tag,
                                            :index_closed,
                                            :random_non_voted_polls,
                                            :summary_polls]
 
  before_action :set_tag, only: :filtered_by_tag
  before_action :set_poll, only: :client_show
  before_action :set_politician, only: :filtered_by_politician

  def index_closed
    respond_to do |format|
      format.json do
        @polls = Poll.includes(:votes, :tags).closed.sort_by {|poll| poll.closing_date}.reverse
      end
    end
  end

  def random_non_voted_polls
    respond_to do |format|
      format.json do
        @polls = []
        active_polls = Poll.includes(:votes, :tags).open
        closed_polls = Poll.includes(:votes, :tags).closed
        @polls << active_polls.first(4)
        @polls << closed_polls.shuffle.first(4 - @polls.size)
        @polls = @polls.flatten.first(4) if @polls.present?
      end
    end
  end

  def summary_polls
    @polls = Poll.includes(:votes, :tags).order(created_at: :desc).limit(40)
  end

  def filtered_by_politician
    if @politician
      respond_to do |format|
        format.json do
          @polls = @politician.polls.includes(:votes).sort_by {|poll| - poll.votes.size}
        end
      end
    else
      render :json => { :errors => t(".not_a_politician") }, :status => 400
    end
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

  def client_show
    if @poll
      set_meta_tags og: {
        title: @poll.title,
        url: request.url,
        image: {
          _: @poll.poll_image,
          width: 600,
          height: 600
        },
        description: @poll.summary,
        type: "article",
        site_name: "seamOS"
      }

      set_meta_tags article: {
        published_time:    @poll.created_at,
        section:           @poll.tags.first.name,
        tag:               @poll.tags.first.name,
      }

      set_meta_tags twitter: {
        card:  "summary_large_image",
        site:  "@seamos",
        title:  @poll.title,
        description: @poll.summary ? @poll.summary.first(199) : nil,
        creator: "@seamos",
        image: {
          _:      @poll.poll_image,
          width:  100,
          height: 100,
        }
      }
    else
      redirect_to "/\#/404"
    end
    @props = {pollIdReducer: {id: params[:id]}}
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

    def set_politician
      @user = User.find_by(id: params[:politician_id])
      ( @user.present? && @user.politico? ) ? @politician = @user : @politician = nil
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
