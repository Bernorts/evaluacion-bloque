class CreateInterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :interviews do |t|
      t.integer :status

      t.timestamps
    end
  end
end
