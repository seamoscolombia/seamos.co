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
    @poll = Poll.new http_params
    @poll.private = get_radiobutton_private
    @poll.usuario = current_user
    totals_hash = {}
    Poll.transaction do
        @poll.save!
        @poll.vote_types.create!(name: "YES")
        @poll.vote_types.create!(name: "NO")
        @poll.vote_types.each do |vote_type|
          totals_hash[vote_type.id] = 0
        end
        @poll.totals = totals_hash.to_s
        @poll.save!

        publish_facebook(@poll)
    end
    flash[:success] = I18n.t(:accion_exitosa)
    redirect_to dashboard_index_path
  rescue Exception
    render :new
  end

  def index
    @polls_filter = params[:polls_filter_select]
    @polls_filter = "1"
    case @polls_filter
    when "0"
      @polls = Poll.all.order('closing_date ASC')
    when nil, "1"
      @polls = Poll.where("closing_date >= ?", Date.today)
      @polls = @polls.select { |poll| poll unless current_user.already_voted?(poll)  }
      @polls = @polls.last
      # @polls = Poll.where("closing_date >= ?", Date.today)
      #ToDo remove ".last" in next iteration.
    when "2"
      @polls = Poll.where("closing_date < ?", Date.today)
    end
  end

  def new
    @poll = Poll.new
  end

  def show
    @poll = Poll.find_by(id: params[:id])
    if @poll.private?
      totals_hash = eval(@poll.totals)
      @votes_code = {}
      totals_hash.each do |k,v|
        vote_type = VoteType.find_by(id: k)
        @votes_code[vote_type.name] = v
      end
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

    def http_params
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
