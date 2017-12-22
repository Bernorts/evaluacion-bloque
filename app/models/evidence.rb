class Evidence < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: {minimum: 5}
  validates :url, presence: true, length: { minimum: 10}
  validates :user_id, presence: true
end
