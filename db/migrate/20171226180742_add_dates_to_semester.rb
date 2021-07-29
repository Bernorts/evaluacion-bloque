# frozen_string_literal: true

class AddDatesToSemester < ActiveRecord::Migration[5.0]
  def change
    add_column :semesters, :start_date, :datetime
    add_column :semesters, :end_date, :datetime
  end
end
