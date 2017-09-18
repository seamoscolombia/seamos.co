class AddTwitterUsernameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :twitter_username, :string
  end
end
