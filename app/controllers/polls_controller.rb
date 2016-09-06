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
end
