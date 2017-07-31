class AddThumbnailToTag < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :thumbnail, :string
  end
end
