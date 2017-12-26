class AgregarIdUserEvidencia < ActiveRecord::Migration[5.0]
  def change
  	add_reference :evidences, :user, index: true
    add_foreign_key :evidences, :users
    end
end
