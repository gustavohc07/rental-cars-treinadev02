class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  has_one :car_rental
  has_one :car, through: :car_rental
  belongs_to :subsidiary

  enum status: { scheduled: 0, canceled: 1, in_progress: 5 }
  validate :end_date_must_be_greater_than_start_date

  def end_date_must_be_greater_than_start_date
    return unless start_date.present? || end_date.present?

    if start_date.blank? || end_date.blank?
      return errors.add(:base, 'Data inicial e/ou data final devem existir!')
    end

    if end_date < start_date
      errors.add(:end_date, 'deve ser maior que data de início')
    end

    if end_date == start_date
      errors.add(:base, 'não devem ser iguais!')
    end

    unless start_date > 1.day.ago
      errors.add(:start_date, 'deve ser maior do que a data de hoje!')
    end
  end

  # Date.today metodo do ruby - falta nele a timezone (pega a data em GW) - UTC 0
  # Date.current método do rails - traz a timezone
  # Time.zone.now método do rails - tem mais controle sobre

 
  # def start_date_equal_or_greater_than_today
  #   return unless start_date.present?

  #   if start_date < Date.current
  #     errors.add(:start_date, 'deve ser maior qu a data de hoje.')
  #   end
  # end

  def cars_available?

    # carros disponiveis
    car_models = CarModel.where(car_category: car_category)
    total_cars = Car.where(car_model: car_models ).count > 0 #aqui cabe fazer, tambem, um joins.


    # Locacoes agendadas
    total_rentals = Rental.where(car_category: car_category, subsidiary: subsidiary)
                          .where("start_date < ? AND end_date > ?", start_date, start_date)
                          .count
    (total_cars - total_rentals) > 0
  end
  
end
