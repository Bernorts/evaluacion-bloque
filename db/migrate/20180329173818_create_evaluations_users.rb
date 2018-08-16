class CreateEvaluationsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations_users do |t|
      t.integer :evaluation_id
      t.integer :user_id
      t.boolean :responsible
      t.integer :temporal_level
      t.timestamps
    end
  end
end
