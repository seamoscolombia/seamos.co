class AddSummaryQuestionToPoll < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :summary, :string
    add_column :polls, :question, :string
  end
end
