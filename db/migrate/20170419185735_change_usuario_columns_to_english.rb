class ChangeUsuarioColumnsToEnglish < ActiveRecord::Migration[5.0]
  def change
    rename_column :usuarios, :primer_apellido,  :first_surname
    rename_column :usuarios, :segundo_apellido, :second_surname
    rename_column :usuarios, :nombres, :names
    rename_column :usuarios, :numero_documento, :document_number
    rename_column :usuarios, :fecha_expedicion, :expedition_date
    rename_column :usuarios, :valido, :approved
  end
end
