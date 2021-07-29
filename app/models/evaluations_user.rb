# frozen_string_literal: true

class EvaluationsUser < ApplicationRecord
  belongs_to :user
  belongs_to :evaluation
  self.primary_key = 'id'
end
