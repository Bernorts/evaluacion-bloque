# frozen_string_literal: true

class UserEvaluation < ApplicationRecord
  belongs_to :user
  belongs_to :evaluation
end
