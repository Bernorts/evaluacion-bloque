class CreateEvidencesEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_join_table :evaluations, :evidences
  end
end
