class AddPollDocumentToPoll < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :poll_document, :string
  end
end
