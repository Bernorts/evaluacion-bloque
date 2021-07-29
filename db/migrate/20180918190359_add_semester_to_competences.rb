# frozen_string_literal: true

class AddSemesterToCompetences < ActiveRecord::Migration[5.0]
  def change
    add_reference :competences, :semester, foreign_key: true
  end
end
