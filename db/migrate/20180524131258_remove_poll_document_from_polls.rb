class RemovePollDocumentFromPolls < ActiveRecord::Migration[5.0]
  def change
    remove_column :polls, :poll_document
  end
end
