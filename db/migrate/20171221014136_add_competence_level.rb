# frozen_string_literal: true

class AddCompetenceLevel < ActiveRecord::Migration[5.0]
  def change
    create_table :competence_levels, id: false do |t|
      t.belongs_to :competence, index: true
      t.belongs_to :level, index: true
      t.text :description
    end
  end
end
