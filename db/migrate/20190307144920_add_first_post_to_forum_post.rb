class AddFirstPostToForumPost < ActiveRecord::Migration[5.0]
  def change
    add_column :forum_posts, :first_post, :boolean, default: false
  end
end
