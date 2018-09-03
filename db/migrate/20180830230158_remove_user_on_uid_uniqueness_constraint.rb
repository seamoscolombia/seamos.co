class RemoveUserOnUidUniquenessConstraint < ActiveRecord::Migration[5.0]
  def up
    remove_index :users, :uid
    add_index :users, :uid
  end
end
