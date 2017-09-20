class FrontendController < ApplicationController
  def index
    @frontend_props = { name: "Stranger" }
    if current_user && (current_user.administrador? || current_user.politico? )
      redirect_to admin_homepage_path
    end
  end

  def prueba
    @poll = Poll.find(params[:id])
    set_meta_tags og: {
      title:    @poll.title,
      image:    @poll.poll_image,
      description: @poll.summary
    }
    @props = {interests: {id: params[:id]}}
  end
end
