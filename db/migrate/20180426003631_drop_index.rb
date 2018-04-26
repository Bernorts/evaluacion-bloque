class DropIndex < ActiveRecord::Migration[5.0]
  def change
    remove_index :evaluations_users, column: [:user_id, :evaluation_id] 
  end
end
