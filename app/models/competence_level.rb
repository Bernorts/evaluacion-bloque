# frozen_string_literal: true

class CompetenceLevel < ApplicationRecord
  belongs_to :competence
  belongs_to :level
end
