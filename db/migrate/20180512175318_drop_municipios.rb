class DropMunicipios < ActiveRecord::Migration[5.0]
  def up
    drop_table :municipios
  end

  def down
    create_table :municipios do |t|
      t.string :nombre
      t.references :departamento, foreign_key: true

      t.timestamps
    end
  end
end

