class AddClosingHourToPoll < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :closing_hour, :string
  end
end
