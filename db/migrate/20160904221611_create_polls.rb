class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.references :usuario, foreign_key: true
      t.string :totals

      t.timestamps
    end
    
    add_index :polls, :title
  end
end
