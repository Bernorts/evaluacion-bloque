class CreateEvidences < ActiveRecord::Migration[5.0]
  def change
    create_table :evidences do |t|
      t.string :name
      t.string :url
      t.string :date
      t.string :string

      t.timestamps
    end
  end
end
