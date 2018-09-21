class DropDebates < ActiveRecord::Migration[5.0]
  def up
    drop_table :debates
  end

  def down
    create_table :debates do |t|
      t.string :title
      t.boolean :published, default: :false
      t.references :poll, foreign_key: true
      t.references :usuario, foreign_key: true
      t.timestamps
    end
  end
end
