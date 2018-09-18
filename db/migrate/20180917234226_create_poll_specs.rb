class CreatePollSpecs < ActiveRecord::Migration
  def change
    create_table :poll_specs do |t|
      t.references :poll, :null => false
      t.string :entry_key, :null => false
      t.text :value, :null => false
      t.integer :value_type, :null => false
      t.boolean :symbol_key, :null => false, :default => true

      t.timestamps
    end

    add_index :poll_specs, :poll_id
    add_index :poll_specs, :entry_key
  end
end