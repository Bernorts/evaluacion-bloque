# frozen_string_literal: true

class CreateGrids < ActiveRecord::Migration[5.0]
  def change
    create_table :grids do |t|
      t.text :description

      t.timestamps
    end
  end
end
