class DropTables < ActiveRecord::Migration[5.0]
  def change
  	drop_table :competence_levels
  	drop_table :user_evaluations
  end
end
