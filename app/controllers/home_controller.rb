class HomeController < ApplicationController
  def index
    @tags = Tag.joins(:polls).where(polls: {active: true}).uniq
    if params[:order_by] == 'by-user-interests'
      @polls = [] and return unless current_user && current_user.tag_ids.present?
      @polls = Poll.active.includes(:votes, :tags).by_user_interests(current_user).sort_by {|poll| poll.vote_count}.first(2)
      @reverse = true
      @polls << Poll.includes(:votes, :tags).sort_by {|poll| poll.vote_count}.first(2 - @polls.size)
    else
      @polls = Poll.active.includes(:votes, :tags).open.sort_by {|poll| poll.send(order_param)}.last(2)
      @polls << Poll.includes(:votes, :tags).sort_by {|poll| poll.send(order_param)}.first(3 - @polls.size)
    end
    @polls = @polls.flatten.uniq
    @polls = @reverse ? @polls.reverse.first(2) : @polls.first(2)
    @subscription = Subscription.new
  end

  private
    def order_param
      case params[:order_by]
      when 'nearest-closing-date-first'
        order_param = 'closing_date'
      when 'newest-first'
        @reverse = true
        order_param = 'created_at'
      when 'most-voted-first'
        @reverse = true
        order_param = 'vote_count'
      when 'by-user-interests'
        order_param = 'vote_count'
      else
        @reverse = true
        order_param = 'created_at'
      end
      order_param
    end
end