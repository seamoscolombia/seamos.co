# == Schema Information
#
# Table name: polls
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  closing_date :date             not null
#  user_id   :integer
#  totals       :string
#  url_image    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PollsController < ApplicationController
  include SessionsHelper
  before_action :validate_poll_closed?, only: :show
  # before_action :validate_closing_date, only: :edit
  before_action :validate_session, except: [:index,
                                            :show,
                                            :client_show,
                                            :filtered_by_politician,
                                            :filtered_by_tag,
                                            :index_closed,
                                            :random_non_voted_polls]
  before_action :validate_admin_user, except: [:index,
                                               :show,
                                               :client_show,
                                               :voted,
                                               :filtered_by_politician,
                                               :filtered_by_tag,
                                               :index_closed,
                                               :random_non_voted_polls]
  before_action :set_tag, only: :filtered_by_tag
  before_action :set_poll, only: :client_show
  before_action :set_politician, only: :filtered_by_politician

  def toggle_status
    @poll = Poll.find_by(id: params[:id])
    @poll.active = !@poll.active
    if @poll.save
      redirect_to admin_polls_path
    end
  end

  def create
    @poll = Poll.new http_params
    @poll.closing_hour = "23:59" if @poll.closing_hour.blank?
    @poll.user = current_user
    @poll.set_tags(tags_param)
    bind_links
    totals_hash = {}
    Poll.transaction do
      @poll.vote_types.build(name: 'SI')
      @poll.vote_types.build(name: 'NO')
      @poll.save! # We need vote_type.id
      @poll.vote_types.each do |vote_type|
        totals_hash[vote_type.id] = 0
      end
      @poll.totals = totals_hash.to_s
      @poll.save!
    end
    flash[:success] = I18n.t(:accion_exitosa)
    redirect_to admin_dashboard_index_path
  rescue Exception => e
    puts "ERROR POLL CREATION: #{e.inspect}"
    logger.debug "ERROR POLL CREATION: #{e.inspect}"
    logger.debug e.backtrace.to_s
    render :new
  end

  def update
    @poll = Poll.find_by(id: params[:id])
    @poll.tags = []
    @poll.set_tags(tags_param)
    bind_links
    if @poll.update(http_params)
      # ActionCable.server.broadcast 'polls_channel', 'changed'
      flash[:success] = I18n.t(:accion_exitosa)
      redirect_to admin_dashboard_index_path
    else
      render :edit
    end
  end

  def destroy
    @poll = Poll.find_by(id: params[:id])
    @poll.destroy
    # ActionCable.server.broadcast 'polls_channel', 'changed'
    redirect_to admin_polls_path
  end

  def edit
    @poll = Poll.find_by(id: params[:id])
    @used_tags = @poll.tags.map(&:name).join(',')
  end

  def index
    respond_to do |format|
      format.html do
        @polls = Poll.search(params[:search_term]).page(params[:page]).per(4) unless params[:search_term].blank?
        @polls ||= Poll.order('id desc').all.page(params[:page]).per(4)
      end
      format.json do
        if params[:order_by] == 'by-user-interests'
          @polls = Poll.includes(:votes, :tags).active.by_user_interests(current_user).sort_by {|poll| poll.vote_count}
          @reverse = true
        else
          @polls = Poll.includes(:votes, :tags).active.sort_by {|poll| poll.send(order_param)}
        end
        @polls = @reverse ? @polls.reverse.first(3) : @polls.first(3)
      end
    end
  end

  def index_closed
    respond_to do |format|
      format.json do
        @polls = Poll.includes(:votes, :tags).closed.sort_by {|poll| poll.closing_date}.reverse
      end
    end
  end

  def filtered_by_tag
    respond_to do |format|
      format.json do
        @polls = @tag.polls.includes(:votes).active.sort_by {|poll| - poll.votes.size} if @tag
      end
    end
  end

  def random_non_voted_polls
    respond_to do |format|
      format.json do
        @polls = Poll.includes(:votes, :tags).active.open
        @polls = @polls.select{|poll| poll.voted_by_user?(current_user.id) == false} if current_user.present?
        @polls = @polls.shuffle.first(4)
        @polls = Poll.includes(:votes, :tags).active.closed.shuffle.first(4) if @polls.blank?
      end
    end
  end

  def filtered_by_politician
    if @politician
      respond_to do |format|
        format.json do
          @polls = @politician.polls.includes(:votes).active.sort_by {|poll| - poll.votes.size}
        end
      end
    else
      render :json => { :errors => t(".not_a_politician") }, :status => 400
    end
  end

  def index_admin
    @filtered_polls = Poll.by_status(params[:status])
    @filtered_polls = @filtered_polls.search(params[:search_term]).page(params[:page]).per(4) unless params[:search_term].blank?
    @polls = if current_user.politico?
               @filtered_polls.order('id desc').where(user_id: current_user.id).page(params[:page]).per(4)
             else
               @filtered_polls.order('id desc').all.page(params[:page]).per(4)
             end
    render :index
  end

  def new
    @poll = Poll.new
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

  def bind_links
    set_project_link
    @poll.related_links.destroy_all if @poll.external_links.present? && links_param != ""
    links_param.split(',').map(&:strip).uniq.each do |url|
      if url.length > 4
        ExternalLink.create!(url: url, poll: @poll)
      end
    end
  end

  def set_project_link
    unless project_link_param[:project_link].blank?
      @poll.project_link.destroy if @poll.project_link
      ExternalLink.create!(url: project_link_param[:project_link], poll: @poll, is_project_link: true)
    end
  end

  def set_tag
    @tag = Tag.find_by(id: params[:tag_id])
  end

  def order_param
    case params[:order_by]
    when 'farest-closing-date-first'
      @reverse = true
      order_param = 'closing_date'
    when 'nearest-closing-date-first'
      order_param = 'closing_date'
    when 'oldest-first'
      order_param = 'created_at'
    when 'newest-first'
      @reverse = true
      order_param = 'created_at'
    when 'most-voted-first'
      @reverse = true
      order_param = 'vote_count'
    when 'less-voted-first'
      order_param = 'vote_count'
    when 'by-user-interests'
      order_param = 'vote_count'
    else
      @reverse = true
      order_param = 'vote_count'
    end
    order_param
  end

  def set_politician
    @user = User.find_by(id: params[:politician_id])
    ( @user.present? && @user.politico? ) ? @politician = @user : @politician = nil
  end

  def tags_param
    params[:poll][:tags]
  end

  def links_param
    params[:poll][:links]
  end

  def project_link_param
    params[:poll].permit(:project_link)
  end

  def http_params
    params.require(:poll).permit(
      :closing_date,
      :closing_hour,
      :description,
      :poll_image,
      :poll_image_cache,
      :title,
      :objective,
      :status,
      :state,
      :summary,
      :question,
      vote_types_attributes: [:name]
    )
  end

  def validate_admin_user
    redirect_to root_path if current_user.role_type == 'ciudadano'
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

  def validate_closing_date
    poll = Poll.find_by(id: params[:id])
    redirect_to root_path and return if poll.closing_date < Date.today.in_time_zone
  end
end
