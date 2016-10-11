class CreateColdocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :coldocuments, id: false do |t|
      t.integer :doc_num, limit: 8
      t.integer :divipol_id, limit: 8

      # t.timestamps
    end
    add_index :coldocuments, :doc_num
    add_index :coldocuments, :divipol_id
  end
end
