class RemoveUsuarioUniqueness < ActiveRecord::Migration[5.0]
  def change
    change_column :usuarios, :numero_documento, :string, :null => true
    change_column :usuarios, :uid, :string, :null => true
  end
end
