class Admin::PollsController < ApplicationController
  before_action :validate_admin_or_politician, only: [:index, :edit, :update]
  before_action :validate_politician, except: [:index, :edit, :update, :toggle_active_flag]
  before_action :validate_superadmin, only: [:toggle_active_flag]
  before_action :set_poll, only: %i(edit update destroy toggle_active_flag)
  before_action :bind_links, only: %i(create update)
  before_action :set_tags, only: %i(create update)

  def create
    if @poll.save
      notify_administrators_about_new_poll
      flash[:success] = "La propuesta fue creada correctamente"
      redirect_to admin_polls_path
    else
      flash[:success] = "La propuesta no pudo ser creada, intente de nuevo por favor"
      render :new
    end
  end

  def update
    if @poll.update(poll_params)
      flash[:success] = "Propuesta correctamente actualizada"
      redirect_to admin_polls_path
    else
      render :edit
    end
  end

  def destroy
    @poll.destroy
    flash[:success] = "Propuesta eliminada"
    redirect_to admin_polls_path
  end

  def edit
    @used_tags = @poll.tags.map(&:name).join(',')
  end

  def index
    @filtered_polls = Poll.by_title(params[:search_term]).by_status(params[:status])
    @filtered_polls = params[:status] == 'inactive' ? @filtered_polls.inactive : @filtered_polls
    @polls = if current_user.politico?
              Kaminari.paginate_array(@filtered_polls.select{ |p| p.user_id == current_user.id}).page(params[:page]).per(4)
             else
              Kaminari.paginate_array(@filtered_polls).page(params[:page]).per(4)
             end
  end

  def new
    @poll = Poll.new
  end


  def toggle_active_flag
    @poll.active = !@poll.active
    if @poll.save
      flash[:success] = "propuesta publicada!" if @poll.active?
      flash[:success] = "propuesta oculta al público" if !@poll.active?
    else
      flash[:error] = "La propuesta no pudo ser actualizada, intente nuevamente"
    end
    redirect_to :back
  end

  private

    def notify_administrators_about_new_poll
      User.administrador.each do |admin|
        AdminNotifierMailer.new_poll_created(@poll, current_user, admin).deliver_later
      end
    end

    def bind_links
      @poll = Poll.new(poll_params) unless @poll
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

    def set_poll
      @poll = Poll.find_by(id: params[:id] || params[:poll_id])
    end

    def set_tags
      @poll.set_tags(tags_param)
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

    def poll_params
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
        :poll_type,
        :summary,
        :question,
        :user_id,
        vote_types_attributes: [:name]
      )
    end
end
