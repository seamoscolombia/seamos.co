class DropDepartamentos < ActiveRecord::Migration[5.0]
  def up
    drop_table :departamentos
  end

  def down
    create_table :departamentos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
