class AddFieldsToEvaluationsUser < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations_user, :evaluation_id, :integer
    add_column :evaluations_user, :user_id, :integer
    add_column :evaluations_user, :responsible, :boolean
    add_column :evaluations_user, :temporal_level, :integer
  end
end
