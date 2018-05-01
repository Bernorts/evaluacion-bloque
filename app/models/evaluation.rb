class Evaluation < ApplicationRecord
	has_many :evaluations_user
	has_many :users, through: :evaluations_user
	belongs_to :competence_levels
	has_and_belongs_to_many :evidences, dependent: :destroy
end
