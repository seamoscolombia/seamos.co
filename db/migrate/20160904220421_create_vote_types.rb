class CreateVoteTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :vote_types do |t|
      t.string :code, null: false

      t.timestamps
    end
    
    add_index :vote_types, :code
  end
end
