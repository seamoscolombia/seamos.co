class Admin::PollsController < ApplicationController
  before_action :validate_admin_or_politician, only: [:index, :edit, :update]
  before_action :validate_politician, except: [:index, :edit, :update, :toggle_active_flag, :one_day_away_from_first_debate_notification, :one_day_away_from_second_debate_notification]
  before_action :validate_superadmin, only: [:toggle_active_flag, :one_day_away_from_first_debate_notification, :one_day_away_from_second_debate_notification]
  before_action :set_poll, only: %i(edit update destroy toggle_active_flag one_day_away_from_first_debate_notification one_day_away_from_second_debate_notification)
  before_action :bind_links, only: %i(create update)
  before_action :set_tags, only: %i(create update)

  include VotesHelper

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
    if @poll.update(poll_params.except(:user_id))
      flash[:success] = "Propuesta correctamente actualizada"
      if @poll.state == "Radica concejal"
        notify_poll_settled
        @poll.specs['poll_settled_notification_sent'] = true
      elsif @poll.state == "Primer debate"
        notify_first_debate_scheduled
        @poll.specs['first_debate_sheduled_notification_sent'] = true
      end
      @poll.save
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
    @filtered_polls = Poll.includes(:tags, votes: [:user]).by_title(params[:search_term]).by_status(params[:status])
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
    if @poll.save && @poll.active?
      flash[:success] = "propuesta publicada!"
      notify_users_about_new_poll
      schedule_voting_reminder
      schedule_voting_closed_notification unless @poll.closed?
      @poll.specs['new_poll_mail_sent'] = true
      @poll.specs['voting_reminder_sent'] = true
      @poll.specs['voting_closed_notification_sent'] = true
      @poll.save
    elsif @poll.save && !@poll.active?
      flash[:success] = "propuesta oculta al público"
    else
      flash[:error] = "La propuesta no pudo ser actualizada, intente nuevamente"
    end
    redirect_to :back
  end

  def one_day_away_from_first_debate_notification
    return if @poll.specs['one_day_left_for_first_debate_notification_sent'] == true
    set_random_polls
    receivers = @poll.votes.map(&:user).uniq
    receivers.each do |receiver|
      UserNotifierMailer.one_day_away_from_first_debate(@poll, receiver, @random_polls).deliver_now
    end
    flash[:success] = "Notificación enviada: A un día del primer debate"
    @poll.specs['one_day_left_for_first_debate_notification_sent'] = true
    @poll.save
    redirect_to :back
  end

  def one_day_away_from_second_debate_notification
    return if @poll.specs['one_day_left_for_second_debate_notification_sent'] == true
    set_random_polls
    receivers = @poll.votes.map(&:user).uniq
    receivers.each do |receiver|
      UserNotifierMailer.one_day_away_from_second_debate(@poll, receiver, @random_polls).deliver_now
    end
    flash[:success] = "Notificación enviada: A un día del primer debate"
    @poll.specs['one_day_left_for_second_debate_notification_sent'] = true
    @poll.save
    redirect_to :back
  end

  private

    def notify_administrators_about_new_poll
      User.administrador.each do |admin|
        AdminNotifierMailer.new_poll_created(@poll, current_user, admin).deliver_later
      end
    end

    def notify_users_about_new_poll
      return if @poll.specs['new_poll_mail_sent'] == true
      set_random_polls
      receivers = related_users
      # if poll is from a new author or theme, notify all users
      receivers = User.all if (@related_by_author.count < 2) || (@related_by_theme.count < 2)
      receivers.each do |receiver|
        UserNotifierMailer.send_new_poll_mail(@poll, receiver, @random_polls).deliver_later
      end
    end

    def schedule_voting_reminder
      return if @poll.specs['voting_reminder_sent'] == true
      set_random_polls
      receivers = related_users - @poll.votes.map(&:user)
      days_from_today = (@poll.closing_date - Date.today).to_i / 2
      receivers.each do |receiver|
        UserNotifierMailer.poll_voting_reminder(@poll, receiver, @random_polls).deliver_later(wait_until: days_from_today.days.from_now) if days_from_today.positive?
      end
    end

    def schedule_voting_closed_notification
      return if @poll.specs['voting_closed_notification_sent'] == true
      set_random_polls
      receivers = @poll.votes.map(&:user).uniq
      days_from_today = (@poll.closing_date - Date.today).to_i
      receivers.each do |receiver|
        UserNotifierMailer.poll_closed_notification(@poll, receiver, @random_polls, vote_count(@poll)).deliver_later(wait_until: days_from_today.days.from_now.end_of_day)
      end
    end


    def notify_poll_settled
      return if @poll.specs['poll_settled_notification_sent'] == true
      set_random_polls
      receivers = @poll.votes.map(&:user).uniq
      receivers.each do |receiver|
        UserNotifierMailer.poll_settled_mail(@poll, receiver, @random_polls).deliver_now
      end
    end

    def notify_first_debate_scheduled
      return if @poll.specs['first_debate_sheduled_notification_sent'] == true
      set_random_polls
      receivers = @poll.votes.map(&:user).uniq
      receivers.each do |receiver|
        UserNotifierMailer.first_debate_scheduled(@poll, receiver, @random_polls).deliver_now
      end
    end

    def related_users
      # only notify users that already voted for polls that have the same author or any tag in common
      @related_by_author = Poll.includes(:tags, votes: [:user]).related_by_author(@poll.user)
      @related_by_theme = Poll.includes(:tags, votes: [:user]).related_by_theme(@poll.tag_ids)
      related_polls = [*@related_by_theme, *@related_by_author].uniq
      related_users = related_polls.each_with_object([]) do |poll, receivers|
        receivers << poll.votes.map(&:user)
      end
      related_users.to_a.flatten.uniq
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
      @poll = Poll.includes(:tags, votes: [:user]).find_by(id: params[:id] || params[:poll_id])
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
