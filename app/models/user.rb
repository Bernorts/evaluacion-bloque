class User < ApplicationRecord
	has_and_belongs_to_many :evaluations
	has_and_belongs_to_many :semesters
	has_many :evidences
  belongs_to :role
  before_save { self.email = email.downcase }
  validates :role_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, on: :create, on: :password

	def full_name
		"#{name} #{last_name}"
	end
end
