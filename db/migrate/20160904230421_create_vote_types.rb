class CreateVoteTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :vote_types do |t|
      t.string :name, null: false
      t.references :poll, foreign_key: true
      t.timestamps
    end
  end
end
