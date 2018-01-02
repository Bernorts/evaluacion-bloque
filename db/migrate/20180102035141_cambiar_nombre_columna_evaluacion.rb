class CambiarNombreColumnaEvaluacion < ActiveRecord::Migration[5.0]
  def change
  	rename_column :evaluations, :evalDate, :eval_date
  end
end
