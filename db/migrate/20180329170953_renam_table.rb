class RenamTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :evaluations_users, :evaluations_user
  end
end
