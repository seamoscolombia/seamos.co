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
  before_action :validate_closing_date, only: :edit
  before_action :validate_session, except: [:index, :show, :filtered_by_politician, :filtered_by_tag]
  before_action :validate_admin_user, except: [:index, :show, :voted, :filtered_by_politician, :filtered_by_tag]
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
        @polls = Poll.order('id desc').all.page(params[:page]).per(4)
      end
      format.json do
        @polls = Poll.includes(:votes, :tags).open.sort_by {|poll| - poll.votes.size}
      end
    end
  end

  def filtered_by_tag
    respond_to do |format|
      format.json do
        @polls = @tag.polls.includes(:votes).open.sort_by {|poll| - poll.votes.size}
      end
    end
  end

  def filtered_by_politician
    if @politician
      respond_to do |format|
        format.json do
          @polls = @politician.polls.includes(:votes).open.sort_by {|poll| - poll.votes.size}
        end
      end
    else
      render :json => { :errors => t(".not_a_politician") }, :status => 400
    end
  end

  def index_admin
    @filtered_polls = Poll.by_status(params[:status])
    @polls = if current_user.politico?
               @filtered_polls.order('id desc').where(user_id: current_user.id).page(params[:page]).per(4)
             else
               @filtered_polls.order('id desc').all.page(params[:page]).per(4)
             end
    render :index
  end

  def last
    @polls_filter = params[:polls_filter_select]
    @polls_filter = '1'
    case @polls_filter
    when '0'
      @polls = Poll.all.order('closing_date ASC')
    when nil, '1'
      @polls = Poll.where('closing_date >= ?', Date.today)
      @polls = @polls.select { |poll| poll unless current_user.already_voted?(poll) }
      @polls = [@polls.last] unless @polls.empty?
    when '2'
      @polls = Poll.where('closing_date < ?', Date.today)
    end
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

  def update
    @poll = Poll.find_by(id: params[:id])
    @poll.tags = []
    @poll.set_tags(tags_param)
    if @poll.update(http_params)
      # ActionCable.server.broadcast 'polls_channel', 'changed'
      flash[:success] = I18n.t(:accion_exitosa)
      redirect_to admin_dashboard_index_path
    else
      render :edit
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

  def set_tag
    @tag = Tag.find(params[:tag_id])
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
      link: (polls_url + "##{poll.id}" if Rails.env.production?)
    )
  end

  def tags_param
    params[:poll][:tags]
  end
  def http_params
    params.require(:poll).permit(
      :closing_date,
      :description,
      :poll_image,
      :poll_image_cache,
      :poll_document,
      :title,
      :status,
      vote_types_attributes: [:name]
    )
  end

  def validate_admin_user
    redirect_to root_path if current_user.role_type == 'ciudadano'
  end

  def validate_poll_closed?
    poll = Poll.find_by(id: params[:id])
    redirect_to polls_path unless poll
  end

  def validate_closing_date
    poll = Poll.find_by(id: params[:id])
    redirect_to root_path and return if poll.closing_date < Date.today
  end
end
