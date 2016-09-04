class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :poll, foreign_key: true
      t.references :usuario, foreign_key: true
      t.references :vote_type #, foreign_key: true

      t.timestamps
    end
  end
end
