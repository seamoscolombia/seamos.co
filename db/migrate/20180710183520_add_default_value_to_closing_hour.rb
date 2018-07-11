class AddDefaultValueToClosingHour < ActiveRecord::Migration[5.0]
  def up
    change_column :polls, :closing_hour, :string, default: '23:59'
  end
  
  def down
    change_column :polls, :closing_hour, :string, default: '23:59'
  end
end
