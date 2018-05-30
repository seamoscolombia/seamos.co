class RemoveAcademicColumnsFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :profession
    remove_column :users, :university
    remove_column :users, :further_studies
  end
end
