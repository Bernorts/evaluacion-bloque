class Competence < ApplicationRecord
  has_many :competence_level
  has_many :levels, through: :competence_level
  belongs_to :semester
end
