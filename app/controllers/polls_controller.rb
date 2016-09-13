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
  before_action :validate_admin_user, except: :index

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new poll_params
    @poll.private = get_radiobutton_private
    @poll.usuario = current_user

    if @poll.save
      flash[:success] = I18n.t(:accion_exitosa)
      redirect_to polls_path
    else
      render :new
    end
  end

  def index
    @polls = Poll.all.order('closing_date DESC')
  end

  def show
    @poll = Poll.find_by(id: params[:id])
    @votes_code = @poll.votes.joins(:vote_type).
        group("vote_types.code").
        count("vote_types.id")
    # Translate vote_types_ids
    @votes_code = @votes_code.map { |key,value| [I18n.t("polls.poll.#{key}"),value] }.to_h
  end

  private
    def poll_params
      params.require(:poll).permit(
        :title,
        :description,
        :closing_date,
        :private
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
      unless po
        redirect_to polls_path
      end
    end
end
