# frozen_string_literal: true

class AddOrderToLevels < ActiveRecord::Migration[5.0]
  def change
    add_column :levels, :order, :integer
  end
end
