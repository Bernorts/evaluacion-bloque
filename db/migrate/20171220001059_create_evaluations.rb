# frozen_string_literal: true

class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.date :date
      t.string :desLevel
      t.string :achLevel
      t.text :retro

      t.timestamps
    end
  end
end
