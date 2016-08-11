class CreateUsuarios < ActiveRecord::Migration[5.0]
  def change
    create_table :usuarios do |t|
      t.string :primer_apellido
      t.string :segundo_apellido
      t.string :nombres
      t.references :tipo_de_documento, foreign_key: true
      t.string :numero_documento
      t.date :fecha_expedicion
      t.references :rol, foreign_key: true
      t.string :nombre_usuario
      t.string :password_digest
      t.boolean :valido

      t.timestamps
    end
  end
end
