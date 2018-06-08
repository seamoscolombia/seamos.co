class HomeController < ApplicationController
  def index
    @tags = Tag.all
    @polls = Poll.includes(:user, :tags)
  end
end