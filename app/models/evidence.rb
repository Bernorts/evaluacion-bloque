class Evidence < ApplicationRecord

  belongs_to :user
  validates :name, presence: true, length: {minimum: 5, message: 'demasiado corto'}
  validates :url, presence: true, length: { minimum: 10, message: 'demasiado corto'}, format: {with: URI::regexp( %w(http https)), message: 'no es un link'}
  validates :user_id, presence: true
  has_many :evaluations, :through => :evaluation_evidences
  has_many :evaluation_evidences, :dependent => :destroy
end
