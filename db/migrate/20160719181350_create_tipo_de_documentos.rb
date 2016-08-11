class CreateTipoDeDocumentos < ActiveRecord::Migration[5.0]
  def change
    create_table :tipo_de_documentos do |t|
      t.string :codigo, null: false
      
      t.timestamps
    end
  end
end
