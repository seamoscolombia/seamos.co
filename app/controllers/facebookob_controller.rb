class FacebookobController < ApplicationController
  def index
    @poll = Poll.find_by(id: params[:id])
    set_meta_tags og: {
      title:    @poll.title,
      image:    @poll.poll_image,
      description: @poll.summary
    }
    render layout: false
  end
end
