class AddDocumentPhotoToUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_reference :usuarios, :document_photo, foreign_key: true
  end
end
