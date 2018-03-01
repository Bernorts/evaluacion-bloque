class Evaluation < ApplicationRecord
	belongs_to :competence_levels
	has_and_belongs_to_many :evidences, dependent: :destroy
	has_many :users, through: :user_evaluations
end
