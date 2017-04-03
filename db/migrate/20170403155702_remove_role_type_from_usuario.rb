class RemoveRoleTypeFromUsuario < ActiveRecord::Migration[5.0]
  def change
    remove_column :usuarios, :role_type, :string
  end
end
