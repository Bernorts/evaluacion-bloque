# frozen_string_literal: true

class CreateCompetences < ActiveRecord::Migration[5.0]
  def change
    create_table :competences do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
