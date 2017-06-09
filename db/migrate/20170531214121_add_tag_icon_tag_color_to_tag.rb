class AddTagIconTagColorToTag < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :tag_icon, :string
    add_column :tags, :tag_color, :string
  end
end
