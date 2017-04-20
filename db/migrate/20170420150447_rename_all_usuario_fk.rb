class RenameAllUsuarioFk < ActiveRecord::Migration[5.0]
  def change
    rename_column :causes, :usuario_id,  :user_id
    rename_column :polls, :usuario_id, :user_id
    rename_column :votes, :usuario_id, :user_id
    rename_column :debate_votes, :usuario_id, :user_id
  end
end
