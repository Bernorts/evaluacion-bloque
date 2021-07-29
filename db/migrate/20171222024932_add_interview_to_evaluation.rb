# frozen_string_literal: true

class AddInterviewToEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_reference :evaluations, :interview, foreign_key: true
  end
end
