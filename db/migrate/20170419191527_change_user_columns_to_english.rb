class ChangeUserColumnsToEnglish < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :primer_apellido,  :fst_surname
    rename_column :users, :segundo_apellido, :snd_surname
    rename_column :users, :nombres, :name
    rename_column :users, :numero_documento, :document_number
    rename_column :users, :fecha_expedicion, :expedition_date
    rename_column :users, :valido, :valid
  end
end