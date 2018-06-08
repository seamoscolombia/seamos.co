class TagsController < ApplicationController
  before_action :set_tag, only: :show

  def index
    @location_from = ''
    @tags = Tag.all
  end

  def show
    @polls = @tag.polls.includes(:votes)
  end

  private

  def set_tag
    @tag = Tag.find_by(id: params[:id])
    unless @tag
      flash[:error] = "El tema no existe"
      redirect_to root_path      
    end
  end
end
