class CreateGlobales < ActiveRecord::Migration[5.0]
  def change
    create_table :globales do |t|
      t.string :codigo, null: false
      t.string :valor, null: false

      t.timestamps
    end

    add_index :globales, :codigo
  end
end
