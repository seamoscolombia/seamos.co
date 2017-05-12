class CreateExternalLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :external_links do |t|
      t.string :url
      t.references :poll, foreign_key: true
      t.timestamps
    end
  end
end
