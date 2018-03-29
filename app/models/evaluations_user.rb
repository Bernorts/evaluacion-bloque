class EvaluationsUser < ApplicationRecord
  belongs_to :user
  belongs_to :evaluations
end
