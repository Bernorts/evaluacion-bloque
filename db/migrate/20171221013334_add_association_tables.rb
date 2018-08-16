class AddAssociationTables < ActiveRecord::Migration[5.0]
=begin
  def change

  	create_table :evidence_revisions do |t|
      t.belongs_to :evidence, index: true
      t.belongs_to :revision, index: true
      t.timestamps
    end

    

  end
=end
end
