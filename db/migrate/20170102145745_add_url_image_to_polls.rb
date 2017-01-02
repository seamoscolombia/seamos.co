class AddUrlImageToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :url_image, :string
  end
end
