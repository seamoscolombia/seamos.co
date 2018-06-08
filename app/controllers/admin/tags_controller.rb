class Admin::TagsController < ApplicationController
  before_action :validate_superadmin, only: %i(new delete)
  before_action :set_tag, only: %i(edit update destroy)

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = I18n.t(:tags_creados, created: "#{@tags.to_s} Temas")
      redirect_to new_admin_tag_path
    else
      render :new
    end
  end

  def edit
  end

  def update    
    if @tag.update(tag_params)
      redirect_to new_admin_tag_path
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    flash[:success] = I18n.t(:accion_exitosa)
    redirect_to new_admin_tag_path
  end
  
  private

  def set_tag
    @tag = Tag.find_by(id: params[:id])
    unless @tag
      flash[:error] = "El tema no existe"
      redirect_to new_admin_tag_path      
    end
  end

  def tag_params
    params.require(:tag).permit(:name, :tag_image, :tag_icon, :thumbnail, :tag_color)
  end
end
