class DropQuestions < ActiveRecord::Migration[5.0]
  def up
    drop_table :questions
  end

  def down
    create_table :questions do |t|
      t.string :description, null: false
      t.references :debate, foreign_key: true
      t.timestamps
    end
  end
end
