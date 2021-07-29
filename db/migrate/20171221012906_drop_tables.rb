# frozen_string_literal: true

class DropTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :competence_levels
  end
end
