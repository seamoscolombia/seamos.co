class AddActiveToPoll < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :active, :boolean, default: false
  end
end
