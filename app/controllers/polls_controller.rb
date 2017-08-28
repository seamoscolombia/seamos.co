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
  before_action :validate_session, except: [:index, :show, :filtered_by_politician, :filtered_by_tag, :index_closed]
  before_action :validate_admin_user, except: [:index, :show, :voted, :filtered_by_politician, :filtered_by_tag, :index_closed]
  before_action :set_tag, only: :filtered_by_tag
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

      # publish_facebook(@poll)
    end
    # ActionCable.server.broadcast 'polls_channel', 'changed'
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
          @polls = Poll.includes(:votes, :tags).open.active.by_user_interests(current_user).sort_by {|poll| poll.vote_count}
          @reverse = true
        else
          @polls = Poll.includes(:votes, :tags).open.active.sort_by {|poll| poll.send(order_param)}
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
        @polls = @tag.polls.includes(:votes).open.active.sort_by {|poll| - poll.votes.size} if @tag
        @closed = @tag.polls.includes(:votes).closed.sort_by {|poll| - poll.votes.size} if @tag
      end
    end
  end

  def filtered_by_politician
    if @politician
      respond_to do |format|
        format.json do
          @polls = @politician.polls.includes(:votes).open.active.sort_by {|poll| - poll.votes.size}
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
    chart_type = 'pie'

    if params[:poll].nil? || (params[:poll][:initial_date].empty? && params[:poll][:final_date].empty?)
      @vote_types = @poll.votes.joins(:vote_type)
                         .group('vote_types.name')
                         .count('vote_types.id')
    else
      i_date = params[:poll][:initial_date]
      f_date = params[:poll][:final_date]
      @vote_types = @poll.votes.joins(:vote_type)
                         .where(created_at: i_date...f_date)
      unless @vote_types.empty?
        @vote_types = @vote_types.group('vote_types.name')
                                 .count('vote_types.id')
      end
    end

    puts "@vote_types: #{@vote_types}"

    respond_to do |format|
      format.html {}
      format.json do
        @poll = Poll.find(params[:id])
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

  def bind_links
    @poll.external_links.destroy_all if @poll.external_links.present?
    links_param.split(',').map(&:strip).uniq.each do |url|
      if url.length > 4
        ExternalLink.create!(url: url, poll: @poll)
      end
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

  def publish_facebook(poll)
    users_graph = Koala::Facebook::API.new(session[:fb_token])
    tvtd_page_token = users_graph.get_page_access_token(Rails.application.secrets.tvtd_page_id.to_s)
    logger.debug "Token in publish_facebook: #{tvtd_page_token} "
    page_graph = Koala::Facebook::API.new(tvtd_page_token)
    logger.debug "page_graph in publish_facebook: #{page_graph} "
    page_graph.put_connections(
      Rails.application.secrets.tvtd_page_id.to_s,
      'feed',
      message: poll.title,
      link: (polls_url + "##{poll.id}")
    )
  end

  def tags_param
    params[:poll][:tags]
  end

  def links_param
    params[:poll][:links]
  end
  def http_params
    params.require(:poll).permit(
      :closing_date,
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
