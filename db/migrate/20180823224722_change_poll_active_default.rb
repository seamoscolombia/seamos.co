class ChangePollActiveDefault < ActiveRecord::Migration[5.0]
  def up
    change_column :polls, :active, :boolean, default: false
  end
  def down
    change_column :polls, :active, :boolean, default: true
  end
end
