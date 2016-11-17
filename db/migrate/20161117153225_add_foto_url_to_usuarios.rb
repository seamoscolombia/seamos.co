class AddFotoUrlToUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :foto_url, :string, null: false
  end
end
