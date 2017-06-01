class ChangeUsuariosToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_table :usuarios, :users
  end
end
