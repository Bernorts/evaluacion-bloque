# frozen_string_literal: true

class CreateCompetenceLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :competence_levels do |t|
      t.text :description

      t.timestamps
    end
  end
end
