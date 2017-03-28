class AddActiveToPoll < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :active, :boolean, default: true
  end
end
