# frozen_string_literal: true

class Evaluation < ApplicationRecord
  has_many :evaluations_user
  has_many :users, through: :evaluations_user
  belongs_to :competence_levels

  has_many :evidences, through: :evaluation_evidences
  has_many :evaluation_evidences, dependent: :destroy
end
