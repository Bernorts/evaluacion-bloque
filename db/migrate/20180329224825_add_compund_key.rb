# frozen_string_literal: true

class AddCompundKey < ActiveRecord::Migration[5.0]
  def change
    add_index :evaluations_users, %w[evaluation_id user_id], unique: true
  end
end
