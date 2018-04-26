class UserEvaluation < ApplicationRecord
  belongs_to :user
  belongs_to :evaluation
  self.primary_key = :user_id,:evaluation_id
end
