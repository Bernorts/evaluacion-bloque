# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :role, foreign_key: true
  end
end
