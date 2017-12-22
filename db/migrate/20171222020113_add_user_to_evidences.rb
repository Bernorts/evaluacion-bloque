class AddUserToEvidences < ActiveRecord::Migration[5.0]
  def change
    add_reference :evidences, :user, foreign_key: true
  end
end
