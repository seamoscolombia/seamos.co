class RenameUsuariosRoleIdToRoleType < ActiveRecord::Migration[5.0]
  def change
    rename_column :usuarios, :role_id, :role_type
  end
end
