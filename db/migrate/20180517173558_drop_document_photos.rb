class DropDocumentPhotos < ActiveRecord::Migration[5.0]
  def up
    drop_table :document_photos
  end

  def down
    create_table :document_photos do |t|
      t.string :url, null: false

      t.timestamps
    end
  end
end
