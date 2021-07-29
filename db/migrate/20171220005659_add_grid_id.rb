# frozen_string_literal: true

class AddGridId < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :grid_id, :integer
  end
end
