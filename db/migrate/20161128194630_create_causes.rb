class CreateCauses < ActiveRecord::Migration[5.0]
  def change
    create_table :causes do |t|
      t.text :description
      t.string :title
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
