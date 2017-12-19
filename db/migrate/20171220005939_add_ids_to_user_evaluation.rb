class AddIdsToUserEvaluation < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_evaluations, :user_id, :integer
  	add_column :user_evaluations, :evaluation_id, :integer
  	remove_column :user_evaluations, :id
  end
end
