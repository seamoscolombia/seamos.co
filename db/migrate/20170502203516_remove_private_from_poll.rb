class RemovePrivateFromPoll < ActiveRecord::Migration[5.0]
  def up
    remove_column :polls, :private, :string
  end

  def down
    add_column :polls, :private, :boolean, default: 'true'
  end
end
