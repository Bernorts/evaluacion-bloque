# frozen_string_literal: true

class Interview < ApplicationRecord
  has_many :evaluations, dependent: :destroy
end
