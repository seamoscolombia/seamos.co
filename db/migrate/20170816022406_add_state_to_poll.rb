class AddStateToPoll < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :state, :integer
  end
end
