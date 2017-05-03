# == Schema Information
#
# Table name: polls
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  closing_date :date             not null
#  usuario_id   :integer
#  totals       :string
#  url_image    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PollsController < ApplicationController
  include SessionsHelper

  before_action :validate_poll_closed?, only: :show
  before_action :validate_session, except: :index
  before_action :validate_admin_user, except: [:index, :show, :voted]

  def toggle_status
    @poll = Poll.find_by(id: params[:id])
    @poll.active = !@poll.active
    if @poll.save
      redirect_to admin_polls_path
    end
  end

  def create
    @poll = Poll.new http_params
    @poll.usuario = current_user
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
  end

  def index
    respond_to do |format|
      format.html do
        @polls = Poll.order('id desc').all.last(10)
      end
      format.json do
        @polls = Poll.where('closing_date >= ?', Date.today).includes(:vote_types)
        @polls
      end
    end
  end

  def index_admin
    @filtered_polls = Poll.by_status(params[:status])
    @polls = if current_user.politico?
               @filtered_polls.order('id desc').where(usuario_id: current_user.id).page(params[:page]).per(4)
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
      format.html do
      end
      format.json do
        if @vote_types['SI'].nil? || @vote_types['NO'].nil?
          chart_type = 'circle'
        end
        @vote_types = @vote_types.to_a.map { |v| { name: "#{v[0]} \n#{v[1]}", votes: v[1] } }
        render json: { vote_types: @vote_types, chart_type: chart_type }
      end
    end
  end

  def update
    @poll = Poll.find_by(id: params[:id])
    if @poll.update(http_params)
      # ActionCable.server.broadcast 'polls_channel', 'changed'
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

  def publish_facebook(poll)
    user_graph = Koala::Facebook::API.new(session[:fb_token])
    tvtd_page_token = user_graph.get_page_access_token(Rails.application.secrets.tvtd_page_id.to_s)
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
end
