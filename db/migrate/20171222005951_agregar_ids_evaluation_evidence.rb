class AgregarIdsEvaluationEvidence < ActiveRecord::Migration[5.0]
  def change

  	drop_table :evaluation_evidences

  	create_table :evaluation_evidences do |t|
      t.belongs_to :evaluation, index: true
      t.belongs_to :evidence, index: true
      t.timestamps
    end
  end
end
