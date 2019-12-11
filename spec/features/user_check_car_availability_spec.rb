#TODO implementar o teste.

require 'rails_helper'

xfeature 'User check car availability' do
  scenario 'successfully' do

    user = User.create!(email: 'test@test', password: '123456')

    subsidiary = Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                                  address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    car_category = CarCategory.create!(name: 'A', daily_rate: 100,
                                       car_insurance: 50,
                                       third_party_insurance: 90)

    client = Client.create!(name: 'Gustavo', email: 'gustavo@test.com',
                            cpf: '743.341.870-99')

    other_car_category = CarCategory.create!(name: 'B', daily_rate: 100,
                                             car_insurance: 50,
                                             third_party_insurance: 90)

    manufacturer = Manufacturer.create!(name: 'Chevrolet')

    car_model = CarModel.create!(name: 'Prisma', fuel_type: 'Flex',
                                 motorization: '1.4',
                                 year: 2018, manufacturer: manufacturer,
                                 car_category: car_category)

    Car.create!(license_plate: 'ABC0001', color: 'Preto', mileage: 0,
                car_model: car_model,
                subsidiary: subsidiary, availability: :available)

    Rental.create!(start_date: 1.day.from_now.strftime('%d/%m/%Y'),
                   end_date: 20.days.from_now.strftime('%d/%m/%Y'),
                   client: client,
                   car_category: car_category,
                   status: :scheduled)

    other_rental = Rental.create!(start_date: 1.day.from_now.strftime('%d/%m/%Y'),
                                  end_date: 20.days.from_now.strftime('%d/%m/%Y'),
                                  client: client,
                                  car_category: car_category,
                                  status: :in_progress)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar uma locação'
  end
end

# car.car_category.subsidiary