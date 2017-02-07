class AddPasswordAndEmailToUsuario < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :email, :string
    add_column :usuarios, :password_hash, :string
    add_column :usuarios, :password_salt, :string
  end
end
