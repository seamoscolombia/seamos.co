class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :codigo, null: false

      t.timestamps
    end
    
    add_index :roles, :codigo
  end
end
