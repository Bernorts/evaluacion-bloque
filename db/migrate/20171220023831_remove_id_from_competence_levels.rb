# frozen_string_literal: true

class RemoveIdFromCompetenceLevels < ActiveRecord::Migration[5.0]
  def change
    remove_column :competence_levels, :id
  end
end
