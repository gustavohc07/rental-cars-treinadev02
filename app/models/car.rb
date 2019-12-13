class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  has_one :car_category, through: :car_model
  has_many :car_rentals
  has_many :rentals, through: :car_rentals

  validates :license_plate, :mileage, :color, presence: {message: 'nao deve ficar em branco'}
  validates :license_plate, uniqueness: {message: 'ja existe no sistema!'}
  validates :mileage, numericality: { greater_than_or_equal_to: 0,
                                      message: 'deve ser maior ou igual a 0' }

  enum status: { available: 0, rented: 5 }

  def name
    "#{car_model.name} - #{license_plate}"
  end

  def price
    car_category.daily_rate +
    car_category.third_party_insurance +
    car_category.car_insurance
  end
end
