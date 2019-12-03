class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: { message: 'não deve ficar em branco.' }
  validates :cnpj, uniqueness: { message: 'já existe!' }
  validates :cnpj, numericality: { only_integer: true, message: 'deve conter apenas números' }
  validates :cnpj, length: { is: 14, message: 'deve conter 14 caracteres' }
end
