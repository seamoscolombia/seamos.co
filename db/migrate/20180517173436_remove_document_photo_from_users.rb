class RemoveDocumentPhotoFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :document_photo_id, :integer
  end
end
