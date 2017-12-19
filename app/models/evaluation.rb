class Evaluation < ApplicationRecord
	belongs_to :revision
	belongs_to :grid
	has_and_belongs_to_many :users
end
