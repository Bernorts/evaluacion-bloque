# frozen_string_literal: true

class AddRetroToEvaluationsUser < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations_users, :retro, :string
  end
end
