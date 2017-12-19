class AddIdsCompetenceLevel < ActiveRecord::Migration[5.0]
  def change
  	add_column :competence_levels, :competence_id, :integer
  	add_column :competence_levels, :level_id, :integer
  end
end
