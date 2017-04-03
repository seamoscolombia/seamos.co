class AddRoleTypeToUsuario < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :role_type, :integer
  end
end
