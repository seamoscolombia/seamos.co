class RemoveEmailOnUserUniquenessConstraint < ActiveRecord::Migration[5.0]
  def up
    remove_index :users, :email
    add_index :users, :email
  end
end
