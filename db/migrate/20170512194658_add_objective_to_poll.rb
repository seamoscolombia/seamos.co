class AddObjectiveToPoll < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :objective, :string
  end
end
