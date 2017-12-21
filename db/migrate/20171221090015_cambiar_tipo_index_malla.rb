class CambiarTipoIndexMalla < ActiveRecord::Migration[5.0]
  def change
  	add_index :competence_levels, :id
  end
end
