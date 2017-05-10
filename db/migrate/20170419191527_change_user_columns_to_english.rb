class ChangeUserColumnsToEnglish < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :first_surname,  :first_surname
    rename_column :users, :segundo_apellido, :second_surname
    rename_column :users, :nombres, :names
    rename_column :users, :numero_documento, :document_number
    rename_column :users, :fecha_expedicion, :expedition_date
    rename_column :users, :valido, :approved
  end
end