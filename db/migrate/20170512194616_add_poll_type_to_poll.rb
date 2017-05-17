class AddPollTypeToPoll < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :poll_type, :integer
  end
end
