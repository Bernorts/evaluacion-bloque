# frozen_string_literal: true

class CreateEvaluationEvidences < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluation_evidences, &:timestamps
  end
end
