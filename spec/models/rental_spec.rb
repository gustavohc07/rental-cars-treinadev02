require 'rails_helper'

describe Rental do
  describe '.end_date_must_be_greater_than_start_date' do
    it 'success' do
      subsidiary = Subsidiary.create!(name: 'Almeidinha Cars',
                                      cnpj: '00000000000000',
                                      address: 'Alameda Santos, 1293')
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com',
                          cpf: '743.341.870-99')
      category = CarCategory.create!(name: 'A', daily_rate: 30,
                                 car_insurance: 30,
                                 third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_model = CarModel.create!(name: 'Onix', year: 2000,
                                   manufacturer: manufacturer, fuel_type: 'Flex',
                                   motorization: '1.0',
                                   car_category: category)
      Car.create!(car_model: car_model, license_plate: 'ABC1234',
                  color: 'Verde', mileage: 0, subsidiary: subsidiary)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now,
                          client: client, car_category: category, subsidiary: subsidiary)

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

      expect(rental.errors.full_messages).to include('não devem ser iguais!')
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

  describe '.cars_available?' do
    
    it 'should be false subsidiary has no cars' do
      client = Client.new(name: 'Gustavo', email: 'gustavo@test.com',
      cpf: '743.341.870-99')

      category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 40,
             third_party_insurance: 50)

      subsidiary = Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                   address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

      rental = Rental.new(start_date: 1.day.from_now,
      end_date: 2.days.from_now,
      client: client,
      car_category: category,
      subsidiary: subsidiary)

      result = rental.cars_available?

      expect(result).to be false

    end

    it 'should be true subsidiary has no cars' do
      subsidiary = Subsidiary.create!(name: 'Almeidinha Cars',
                                      cnpj: '00000000000000',
                                      address: 'Alameda Santos, 1293')
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com',
                          cpf: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30,
                                 car_insurance: 30,
                                 third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_model = CarModel.create!(name: 'Onix', year: 2000,
                                   manufacturer: manufacturer, fuel_type: 'Flex',
                                   motorization: '1.0',
                                   car_category: category)
      Car.create!(car_model: car_model, license_plate: 'ABC1234',
                  color: 'Verde', mileage: 0, subsidiary: subsidiary)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now,
                          client: client, car_category: category)

      result = rental.cars_available?

      expect(result).to be true

    end

    it 'should be false if subsidiary has no cars from rental category' do
      subsidiary = Subsidiary.create!(name: 'Almeidinha Cars',
                                      cnpj: '00000000000000',
                                      address: 'Alameda Santos, 1293')
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com',
                          cpf: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30,
                                 car_insurance: 30,
                                 third_party_insurance: 30)
      other_category = CarCategory.new(name: 'A', daily_rate: 30,
                                 car_insurance: 30,
                                 third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_model = CarModel.create!(name: 'Onix', year: 2000,
                                   manufacturer: manufacturer, fuel_type: 'Flex',
                                   motorization: '1.0',
                                   car_category: category)
      Car.create!(car_model: car_model, license_plate: 'ABC1234',
                  color: 'Verde', mileage: 0, subsidiary: subsidiary)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now,
                          client: client, car_category: other_category)

      result = rental.cars_available?
      
      expect(result).to be false
      
    end

    it 'should be false if subsidiary has rentals scheduled' do
      subsidiary = Subsidiary.create!(name: 'Almeidinha Cars',
                                      cnpj: '00000000000000',
                                      address: 'Alameda Santos, 1293')
      client = Client.new(name: 'Fulano Sicrano', email: 'fulano@test.com',
                          cpf: '743.341.870-99')
      category = CarCategory.new(name: 'A', daily_rate: 30,
                                 car_insurance: 30,
                                 third_party_insurance: 30)
      other_category = CarCategory.new(name: 'A', daily_rate: 30,
                                 car_insurance: 30,
                                 third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_model = CarModel.create!(name: 'Onix', year: 2000,
                                   manufacturer: manufacturer, fuel_type: 'Flex',
                                   motorization: '1.0',
                                   car_category: category)
      Car.create!(car_model: car_model, license_plate: 'ABC1234',
                  color: 'Verde', mileage: 0, subsidiary: subsidiary)
      scheduled_rental = Rental.create!(start_date: 1.day.from_now, end_date: 3.days.from_now,
                          client: client, car_category: other_category, subsidiary: subsidiary, status: :scheduled)
      new_rental = Rental.new(start_date: 1.day.from_now, subsidiary: subsidiary, end_date: 2.days.from_now,
                          client: client, car_category: other_category)

      result = new_rental.cars_available?

      expect(result).to be false

    end

  end
end

