class TagsController < ApplicationController
  before_action :tag_params, only: :set_tags
  before_action :validate_superadmin, only: %i(create new delete)
  before_action :set_user, only: :user_interests

  def new
    @tag = Tag.new
  end

  def index
    respond_to do |format|
      format.html do
        @location_from = ''
        @tags = Tag.all
      end
      format.json do
        @tags = Tag.all
      end
    end
  end

  def user_interests
    respond_to do |format|
      format.json do
        @tags = Tag.all
      end
    end
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = I18n.t(:tags_creados, created: "#{@tags.to_s} etiquetas")
    else
      logger.debug "ERROR TAG CREATION: #{@tag.errors.messages}"
    end
    redirect_back(fallback_location: root_path)
  end

  def delete
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :image_tag)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def validate_superadmin
    redirect_to :root if current_user.role_type != 'administrador'
  end
end
