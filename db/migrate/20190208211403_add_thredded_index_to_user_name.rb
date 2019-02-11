class AddThreddedIndexToUserName < ActiveRecord::Migration[5.0]
  def up
    DbTextSearch::CaseInsensitive.remove_index(
      connection, Thredded.user_class.table_name, Thredded.user_name_column, unique: true)
  end
  def down
    remove_index "users", name: "users_names_lower"
  end
end
