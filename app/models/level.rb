class Level < ApplicationRecord
  has_many :competence_level
  has_many :competences, through: :competence_level
  validates :name, uniqueness: true
end
