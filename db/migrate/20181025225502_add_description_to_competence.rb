class AddDescriptionToCompetence < ActiveRecord::Migration[5.0]
  def change
    add_column :competences, :evidences, :text, default: ''
  end
end
