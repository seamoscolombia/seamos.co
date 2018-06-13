class HomeController < ApplicationController
  def index
    @tags = Tag.joins(:polls).uniq
    @polls = Poll.includes(:user, :tags)
  end
end