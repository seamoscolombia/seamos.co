class DropCauses < ActiveRecord::Migration[5.0]
  def up
    drop_table :causes
  end

  def down
   create_table :causes do |t|
     t.text :description
     t.string :title
     t.references :usuario, foreign_key: true

     t.timestamps
    end
  end
end
