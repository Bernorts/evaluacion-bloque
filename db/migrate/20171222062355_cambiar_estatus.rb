class CambiarEstatus < ActiveRecord::Migration[5.0]
  def change
  	remove_column :interviews, :status
  	add_column :interviews, :evaluated, :boolean
  end
end
