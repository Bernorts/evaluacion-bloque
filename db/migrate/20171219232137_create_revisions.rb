# frozen_string_literal: true

class CreateRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :revisions do |t|
      t.datetime :date
      t.boolean :reviewed
      t.timestamps
    end
  end
end
