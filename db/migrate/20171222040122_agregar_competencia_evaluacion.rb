class AgregarCompetenciaEvaluacion < ActiveRecord::Migration[5.0]
  def change
  	add_column :evaluations, :competence_id, :integer
  end
end
