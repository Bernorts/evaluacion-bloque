class NuevaGrid < ActiveRecord::Migration[5.0]
  def change

  	drop_table :competence_levels

  	create_table :competence_levels do |t|
      t.belongs_to :competence, index: true
      t.belongs_to :level, index: true
      t.text :description
    end

  end
end
