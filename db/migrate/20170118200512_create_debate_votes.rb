class CreateDebateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :debate_votes do |t|
      t.references :question #, foreign_key: true
      t.references :usuario, foreign_key: true
      t.references :debate, foreign_key: true

      t.timestamps
    end
  end
end
