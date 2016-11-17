class CreateDocumentPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :document_photos do |t|
      t.string :url, null: false

      t.timestamps
    end
  end
end
