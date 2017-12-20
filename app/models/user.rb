class User < ApplicationRecord
  belongs_to :role
  before_save { self.email = email.downcase }
  validates :role_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
end
