class Level < ApplicationRecord
	has_many :competences, through: :competence_level
end
