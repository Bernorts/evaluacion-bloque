class AddColumnsUserEvaluations < ActiveRecord::Migration[5.0]
  def change
    add_column :user_evaluations, :responsible, :integer
    add_column :user_evaluations, :temporal_level, :integer
  end
end
