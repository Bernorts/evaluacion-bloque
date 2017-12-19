class Competence < ApplicationRecord
	has_many :levels, through: :competence_level
end
