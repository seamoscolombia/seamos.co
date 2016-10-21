# == Schema Information
#
# Table name: polls
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  private      :boolean          default(TRUE), not null
#  closing_date :date             not null
#  usuario_id   :integer
#  totals       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PollsController < ApplicationController
  include SessionsHelper

  before_action :validate_poll_closed?, only: :show
  before_action :validate_session
  before_action :validate_admin_user, except: [:index, :show]


  def create
    @poll = Poll.new poll_params
    @poll.private = get_radiobutton_private
    @poll.usuario = current_user
    #ToDo remove line below
    # @poll.totals = {"blank": 0, "yes": 0, "no": 0}.to_s
    if @poll.save
      publish_facebook(@poll)
      flash[:success] = I18n.t(:accion_exitosa)
      redirect_to polls_path
    else
      render :new
    end
  end

  def index
    @polls_filter = params[:polls_filter_select]
    case @polls_filter
    when "0"
      @polls = Poll.all.order('closing_date ASC')
    when nil, "1"
      @polls = Poll.where("closing_date >= ?", Date.today)
    when "2"
      @polls = Poll.where("closing_date < ?", Date.today)
    end
    @polls
  end

  def new
    @poll = Poll.new
    3.times do |index|
      @poll.vote_types.build(name: "a"*index)
    end
  end

  def show
    @poll = Poll.find_by(id: params[:id])
    if @poll.private?
      @votes_code = @poll.vote_types
    else
      @votes_code = @poll.votes.joins(:vote_type).
          group("vote_types.name").
          count("vote_types.id")
    end
  end

  private

    def publish_facebook(poll)

      user_graph = Koala::Facebook::API.new(session[:fb_token])

      tvtd_page_token = user_graph.get_page_access_token("#{Rails.application.secrets.tvtd_page_id}")
      page_graph = Koala::Facebook::API.new(tvtd_page_token)

      page_graph.put_connections(
        "#{Rails.application.secrets.tvtd_page_id}",
         "feed",
         :message => poll.title,
         :link => (polls_url+"##{poll.id}" if Rails.env.production? )
      )
    end



    def poll_params
      params.require(:poll).permit(
        :closing_date,
        :description,
        :private,
        :title,
        {vote_types_attributes: [:name]}
      )
    end

    def get_radiobutton_private
      params[:poll][:private] = params[:poll][:private] == 'true' ? true : false
    end

    def validate_admin_user
       unless current_user.role.code == "administrador"
         redirect_to root_path
       end
    end

    def validate_poll_closed?
      poll = Poll.find_by(id: params[:id] )
      unless poll
        redirect_to polls_path
      end
    end
end
