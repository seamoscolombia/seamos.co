class TagsController < ApplicationController
  before_action :set_tags, only: :create
  before_action :tag_params, only: :set_tags
  before_action :existing_tags, only: %i(create new)
  before_action :validate_superadmin, only: %i(create new delete)

  def new
    @tag = Tag.new
  end

  def index
    respond_to do |format|
      format.html do
        @tags = Tag.all.map(&:name)
      end
      format.json do
        @tags = Tag.all
        render json: @tags
      end
    end
  end

  def create
    @new_tags = 0
    @dup_tags = 0
    @tags.each do |name|
      name.delete!(' ')
      @tag = Tag.new(name: name.downcase)
      (@tag.save ? @new_tags += 1 : @dup_tags += 1) unless name == ''
    end
    flash[:danger] = 'el nombre de ' + @dup_tags.to_s + ' etiquetas ya ha sido tomado' if @dup_tags > 0
    flash[:success] = I18n.t(:tags_creados, created: @new_tags.to_s + ' etiquetas') if @new_tags > 0
    redirect_back(fallback_location: root_path)
  end

  def delete
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_tags
    @tags = tag_params[:name].split(',')
  end

  def existing_tags
    @existing_tags = Tag.all
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

  def validate_superadmin
    redirect_to :root if current_user.role_type != 'administrador'
  end
end
