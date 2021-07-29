# frozen_string_literal: true

class CreateCompetenceSemestersTable < ActiveRecord::Migration[5.0]
  def change
    # If you want to add an index for faster querying through this join:
    create_join_table :competences, :semesters, table_name: :competence_semesters do |t|
      t.index :competence_id
      t.index :semester_id
    end

    remove_column :competences, :semester_id
  end
end
