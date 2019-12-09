class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category

  validate :end_date_must_be_greater_than_start_date

  def end_date_must_be_greater_than_start_date
    #return unless start_date.present? || end_date.present?

    if start_date.blank? || end_date.blank?
      return errors.add(:base, 'devem exister')
    end

    if end_date < start_date
      errors.add(:end_date, 'deve ser maior que data de início')
    end

    if end_date == start_date
      errors.add(:base, 'não devem ser iguais!')
    end
  end
end
