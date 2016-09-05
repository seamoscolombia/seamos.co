class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :code, null: false

      t.timestamps
    end
    
    add_index :roles, :code, unique: true
  end
end
