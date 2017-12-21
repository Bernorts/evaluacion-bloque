class CreateEvidences < ActiveRecord::Migration[5.0]
  def change
    create_table :evidences do |t|
      t.string :name
      t.string :url
      t.datetime :date

      t.timestamps
    end
  end
end
