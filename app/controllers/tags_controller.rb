class TagsController < ApplicationController
  before_action :tag_params, only: :set_tags
  before_action :validate_superadmin, only: %i(create new delete edit)

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

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = I18n.t(:tags_creados, created: "#{@tags.to_s} etiquetas")
      redirect_to admin_tags_new_path and return
    else
      logger.debug "ERROR TAG CREATION: #{@tag.errors.messages}"
      render :new and return
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:success] = I18n.t(:accion_exitosa)
      redirect_to admin_tags_new_path
    else
      render :edit
    end
  end

  def delete
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :tag_image)
  end

  def validate_superadmin
    redirect_to :root if current_user.role_type != 'administrador'
  end
end
