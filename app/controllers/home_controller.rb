class HomeController < ApplicationController
  def index
    @tags = Tag.joins(:polls).uniq
    @polls = Poll.includes(:user, :tags, :votes).sort_by {|poll| poll.vote_count}.last(2)
  end
end