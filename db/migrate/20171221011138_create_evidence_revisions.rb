class CreateEvidenceRevisions < ActiveRecord::Migration[5.0]
=begin
  def change
    create_table :evidence_revisions do |t|
      t.integer :evidence_id
      t.integer :revision_id

      t.timestamps
    end
  end
=end
end
