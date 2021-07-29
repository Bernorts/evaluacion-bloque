# frozen_string_literal: true

class CompetenceSemester < ApplicationRecord
  belongs_to :competence
  belongs_to :semester
end
