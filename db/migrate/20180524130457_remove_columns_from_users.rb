class RemoveColumnsFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :document_number
    remove_column :users, :expedition_date
  end
end
