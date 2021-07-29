# frozen_string_literal: true

class User < ApplicationRecord
  has_many :evaluations_user
  has_many :evaluations, through: :evaluations_user
  has_and_belongs_to_many :semesters
  has_many :evidences, dependent: :destroy
  belongs_to :role
  before_save { self.email = email.downcase }
  validates :role_id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create, on: :password

  def full_name
    "#{name} #{last_name}"
  end
end
