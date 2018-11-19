class Competence < ApplicationRecord
  default_scope { order('id ASC') }
  has_many :competence_level
  has_many :levels, through: :competence_level
  belongs_to :semester
end
