class Admin::PollsController < ApplicationController
  before_action :validate_admin_or_politician, only: :index
  before_action :validate_politician, except: :index
  before_action :set_poll, only: %i(edit update destroy)
  before_action :bind_links, only: %i(create update)
  before_action :set_tags, only: %i(create update)

  def create
    if @poll.save
      flash[:success] = "La propuesta fue creada correctamente"
      redirect_to admin_polls_path
    else
      flash[:success] = "La propuesta no pudo ser creada, intente de nuevo por favor"
      render :new
    end
  end

  def show
    @poll = Poll.find_by(id: params[:id])
    @vote_types = @poll.votes.joins(:vote_type).group('vote_types.name').count('vote_types.id')
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
    @polls = if current_user.politico?
               @filtered_polls.where(user_id: current_user.id).page(params[:page]).per(4)
             else
               Kaminari.paginate_array(@filtered_polls).page(params[:page]).per(4)
             end
  end

  def new
    @poll = Poll.new
  end

  private

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
      @poll = Poll.find_by(id: params[:id])
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
