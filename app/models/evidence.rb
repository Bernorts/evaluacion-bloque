class Evidence < ApplicationRecord
	 has_and_belongs_to_many :revisions
end
