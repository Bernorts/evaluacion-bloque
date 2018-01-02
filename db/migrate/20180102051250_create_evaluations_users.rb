class CreateEvaluationsUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :evaluations, :users
  end
end
