class RestructurarTablas < ActiveRecord::Migration[5.0]
  def change
  	drop_table :revisions
  	drop_table :evidences
  	drop_table :evidence_revisions

  	rename_column :evaluations, :date, :reqDate
  	add_column :evaluations, :evalDate, :date
  end
end
