# frozen_string_literal: true

class CreateSemesterUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :semesters, :users
  end
end
