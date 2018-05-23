class DropTipoDeDocumentos < ActiveRecord::Migration[5.0]
  def up
    drop_table :tipo_de_documentos
  end

  def down
    create_table :tipo_de_documentos do |t|
      t.string :codigo, null: false
      
      t.timestamps
    end
    
    add_index :tipo_de_documentos, :codigo, unique: true
  end
end
