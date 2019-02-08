class PollsController < ApplicationController
  include PollsHelper
  before_action :check_if_is_publish_link, only: :show
  before_action :set_poll, only: :show
  before_action :set_random_polls, only: :show
  before_action :set_metas, only: :show
  before_action :set_status_image, only: :show

  def index
    @polls_by_year = Poll.active.includes(:votes, :tags).group_by { |m| m.created_at.year}.sort.reverse.to_h
  end

  def show
    @tag = @poll.default_tag
    @author = @poll.user
  end

  private

  def set_status_image
    @status_image = if @poll.read_attribute_before_type_cast(:poll_type) == 0
      Rails.application.config.cp_base_image_url
    else
      Rails.application.config.pa_base_image_url
    end

    if  @poll.read_attribute_before_type_cast(:state).present?
      @status_image += @poll.read_attribute_before_type_cast(:state).to_s + ".png"
    else
      @status_image += "0.png"
    end
  end

  def set_poll
    @poll = Poll.includes(:tags, :user).find_by(id: params[:id])
    unless @poll
      flash[:error] = "la propuesta no existe"
      redirect_to root_path
    end
    if !@poll.active? && !current_user.try(:administrador?)
      flash[:error] = "la propuesta aún no está abierta a votación"
      redirect_to root_path
    end
  end

  def check_if_is_publish_link
    if params[:publish_link] && !current_user.try(:administrador?)
      flash[:error] = "Debes iniciar sesión como administrador para aprobar la propuesta para su publicación"
      redirect_to root_path
    end
  end
end
