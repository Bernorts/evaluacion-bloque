# frozen_string_literal: true

class Competence < ApplicationRecord
  default_scope { order('id ASC') }
  has_many :competence_level
  has_many :levels, through: :competence_level
  has_many :competence_semester
  has_many :semesters, through: :competence_semester
end
