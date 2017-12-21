class ModificarMalla < ActiveRecord::Migration[5.0]
  def change
  	drop_table :grids

  	create_table :grids do |t|
      t.belongs_to :levels, index: true
      t.belongs_to :competences, index: true
      t.text :description
      t.timestamps
    end

  end
end
