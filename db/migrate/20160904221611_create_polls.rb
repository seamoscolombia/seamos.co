class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :private, null: false, default: true
      t.date :closing_date, null: false
      t.references :usuario, foreign_key: true
      t.string :totals

      t.timestamps
    end
    
    add_index :polls, :title
  end
end
