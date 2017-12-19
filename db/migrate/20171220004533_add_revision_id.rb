class AddRevisionId < ActiveRecord::Migration[5.0]
  def change
  	add_column :evaluations, :revision_id, :integer
  end

end
