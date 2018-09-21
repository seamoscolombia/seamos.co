class DropGlobals < ActiveRecord::Migration[5.0]
  def up
    drop_table :globals
  end

  def down
    create_table :globals do |t|
      t.string :code, null: false
      t.string :value, null: false

      t.timestamps
    end

    add_index :globals, :code, unique: true
  end
end
