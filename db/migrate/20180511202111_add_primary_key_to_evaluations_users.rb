class AddPrimaryKeyToEvaluationsUsers < ActiveRecord::Migration[5.0]
  def change
	execute "ALTER TABLE evaluations_users DROP CONSTRAINT evaluations_users_pkey"
  	add_column :evaluations_users, :id, :primary_key
  end
end
