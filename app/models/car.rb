class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary

  validates :license_plate, :mileage, :color, presence: {message: 'nao deve ficar em branco'}
  validates :license_plate, uniqueness: {message: 'ja existe no sistema!'}
  validates :mileage, numericality: { greater_than_or_equal_to: 0,
                                      message: 'deve ser maior ou igual a 0' }

  enum availability: [ :available, :rented, :maintenance ]
end
