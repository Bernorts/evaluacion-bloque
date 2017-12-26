class CreateEvaluationEvidences < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluation_evidences do |t|

      t.timestamps
    end
  end
end
