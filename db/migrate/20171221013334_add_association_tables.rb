class AddAssociationTables < ActiveRecord::Migration[5.0]
  def change

  	create_table :evidence_revisions do |t|
      t.belongs_to :evidence, index: true
      t.belongs_to :revision, index: true
      t.timestamps
    end

    create_table :user_evaluations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :evaluation, index: true
      t.timestamps
    end
    
  end
end
