class AddIndice < ActiveRecord::Migration[5.0]
  def change
  	add_column :competence_levels, :id, :integer
  end
end
