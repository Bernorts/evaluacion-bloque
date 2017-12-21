class RemoveIdFromRevisionEvidence < ActiveRecord::Migration[5.0]
  def change
  	remove_column :evidence_revisions, :id
  end
end
