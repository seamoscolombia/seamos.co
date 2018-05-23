class DropPollStates < ActiveRecord::Migration[5.0]
  def up
    drop_table :poll_states
  end

  def down
    create_table :poll_states do |t|
      t.string :name
      t.integer :status
      t.integer :ordinal_position
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
