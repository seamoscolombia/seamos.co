class CreateUsuarios < ActiveRecord::Migration[5.0]
  def change
    create_table :usuarios do |t|
      t.string :primer_apellido
      t.string :segundo_apellido
      t.string :nombres
      t.references :tipo_de_documento, foreign_key: true
      t.string :numero_documento, null: false
      t.date :fecha_expedicion
      t.references :role, foreign_key: true
      t.string :uid, null: false
      t.boolean :valido

      t.timestamps
    end
    add_index :usuarios, :uid, unique: true
    add_index :usuarios, :numero_documento
    add_index :usuarios, [:tipo_de_documento_id, :numero_documento], unique: true
  end
end
