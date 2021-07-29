# frozen_string_literal: true

class AgregarIdUsarioEval < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :user_id, :integer
  end
end
