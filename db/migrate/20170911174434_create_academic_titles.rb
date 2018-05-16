class CreateAcademicTitles < ActiveRecord::Migration[5.0]
  def change
    create_table :academic_titles do |t|
      t.string :title
      t.string :period
      t.string :institute
      t.string :annotation
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
