class Renametable < ActiveRecord::Migration[5.0]
  def change
    rename_table :evaluations_user,:evaluations_users
  end
end
