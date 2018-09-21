class DropDebateVotes < ActiveRecord::Migration[5.0]
  def up
    drop_table :debate_votes
  end

  def down
    create_table :debate_votes do |t|
      t.references :question #, foreign_key: true
      t.references :usuario, foreign_key: true
      t.references :debate, foreign_key: true

      t.timestamps
    end
  end
end
