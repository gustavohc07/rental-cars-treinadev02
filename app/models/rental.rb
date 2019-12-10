class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category

  enum status: [:in_progress, :scheduled, :canceled]
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
end
