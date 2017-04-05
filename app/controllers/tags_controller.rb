class TagsController < ApplicationController
  before_action :set_tags, only: :create
  before_action :tag_params, only: :set_tags
  before_action :existing_tags, only: %i(create new)
  before_action :validate_superadmin, only: %i(create new)

  def new
    @tag = Tag.new
  end

  def create
    @created_tags = 0
    @already_created_tags = 0
    @tags.map do |name|
      if @existing_tags.include? name.delete(' ')
        @already_created_tags += 1
      else
        @tag = Tag.new(name: name)
        if @tag.save
          @existing_tags.push(name)
          @created_tags += 1
        end
       end
    end
    redirect_to :back if @created_tags + @already_created_tags == @tags.count
  end

  private

  def set_tags
    @tags = tag_params[:name].split(',')
  end

  def existing_tags
    @existing_tags = Tag.all.map(&:name)
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

  def validate_superadmin
    redirect_to :root if current_user.role_type != "administrador"
  end
end
