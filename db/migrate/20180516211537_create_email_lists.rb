class CreateEmailLists < ActiveRecord::Migration[5.0]
  def change
    create_table :email_lists do |t|
      t.string :name
      t.string :identifier

      t.timestamps
    end
  end
end
