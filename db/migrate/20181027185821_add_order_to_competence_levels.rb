# frozen_string_literal: true

class AddOrderToCompetenceLevels < ActiveRecord::Migration[5.0]
  def change
    add_column :competence_levels, :order, :integer
  end
end
