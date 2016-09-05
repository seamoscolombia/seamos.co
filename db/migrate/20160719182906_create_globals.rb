class CreateGlobals < ActiveRecord::Migration[5.0]
  def change
    create_table :globals do |t|
      t.string :code, null: false
      t.string :value, null: false

      t.timestamps
    end

    add_index :globals, :code, unique: true
  end
end
