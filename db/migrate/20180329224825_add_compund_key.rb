class AddCompundKey < ActiveRecord::Migration[5.0]
  def change
    add_index :evaluations_users, ["user_id", "evaluation_id"], :unique => true
  end
end
