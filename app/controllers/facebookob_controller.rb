class FacebookobController < ApplicationController
  def index
    @poll = Poll.find_by(id: params[:id])
    render layout: false
  end
end
