class Semester < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :correct_dates?

  def correct_dates?
    if end_date < start_date
      errors.add :end_date, "debe ser después de la fecha de inicio"
    end
  end
end
