class RemoveTipoDeDocumentoFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :tipo_de_documento_id, :integer
  end
end
