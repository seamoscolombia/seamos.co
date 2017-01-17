class CreateDebates < ActiveRecord::Migration[5.0]
  def change
    create_table :debates do |t|
      t.string :title
      t.boolean :published, default: :false
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
