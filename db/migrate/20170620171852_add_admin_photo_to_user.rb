class AddAdminPhotoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin_photo, :string
  end
end
