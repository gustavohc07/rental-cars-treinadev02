require 'rails_helper'

describe Rental do
  describe '.end_date_must_be_greater_than_start_date' do
    it 'success' do
      client = Client.new(name: 'Gustavo', email: 'gustavo@test.com',
                          cpf: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 40,
                                 third_party_insurance: 50)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now,
                          client: client,
                          car_category: category)

      rental.valid?

      expect(rental.errors).to be_empty
      # expect(rental.errors.empty?).to eq true

      # Deve existir o client e o category, pois o belongs_to é necessário para as rentals
    end

    it 'end date less than start date' do
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.ago)

      rental.valid? # verifica se o objeto pode ser persistido no banco de dados

      expect(rental.errors.full_messages).to include(
        'End date deve ser maior que data de início'
      )
    end

    it 'end date equal to start date' do
      client = Client.new(name: 'Gustavo', email: 'gustavo@test.com',
                          cpf: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 40,
                                 third_party_insurance: 50)
      rental = Rental.new(start_date: '12/12/2019', end_date: '12/12/2019', client: client,
                          car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to eq(['não devem ser iguais!'])
    end

    it 'start date must exist' do

      client = Client.new(name: 'Gustavo', email: 'gustavo@test.com',
                          cpf: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 40,
                                 third_party_insurance: 50)
      rental = Rental.new(start_date: nil, end_date: '12/12/2019',
                          client: client,
                          car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to eq(['Data inicial e/ou data final devem existir!'])
    end

    it 'end date must exist' do
      client = Client.new(name: 'Gustavo', email: 'gustavo@test.com',
                          cpf: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 40,
                                 third_party_insurance: 50)
      rental = Rental.new(start_date: '12/12/2019', end_date: nil,
                          client: client,
                          car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to eq(['Data inicial e/ou data final devem existir!'])
    end
    it 'start date must be greater than today' do
      client = Client.new(name: 'Gustavo', email: 'gustavo@test.com',
                          cpf: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 40,
                                 third_party_insurance: 50)
      rental = Rental.new(start_date: 1.day.ago, end_date: 2.days.from_now,
                          client: client,
                          car_category: category)

      rental.valid?

      expect(rental.errors.full_messages).to eq(['Start date deve ser maior do que a data de hoje!'])
    end
  end
end
