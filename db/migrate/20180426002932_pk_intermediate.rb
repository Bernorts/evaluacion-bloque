class PkIntermediate < ActiveRecord::Migration[5.0]
  def change
  end
  execute "ALTER TABLE evaluations_users ADD PRIMARY KEY (user_id, evaluation_id);"
end
