class CrearEvaluationTable < ActiveRecord::Migration[5.0]
  def change
  	drop_table :evaluations

  	create_table :evaluations do |t|
      t.date :reqDate
      t.date :evalDate
      t.integer :desLevel
      t.integer :achLevel
      t.text :retro
      t.timestamps
    end

  end
end
