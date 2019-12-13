require 'rails_helper'

feature 'User schedule rental' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :employee)
    client = Client.create!(name: 'Gustavo', email: 'gustavo@test.com',
                            cpf: '743.341.870-99')
    category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 40,
                                   third_party_insurance: 50)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    fill_in 'Data de início', with: 1.day.from_now.strftime('%d/%m/%Y')
    fill_in 'Data de fim', with: 2.days.from_now.strftime('%d/%m/%Y')
    select "#{client.name} - #{client.cpf}", from: 'Cliente'
    select category.name, from: 'Categoria do Carro'
    click_on 'Enviar'

    expect(page).to have_content('Locação agendada com sucesso')
    expect(page).to have_content("Data de início: #{1.day.from_now.strftime('%d/%m/%Y')}")
    expect(page).to have_content("Data de fim: #{2.days.from_now.strftime('%d/%m/%Y')}")
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
    expect(page).to have_content('Categoria')
    expect(page).to have_content(category.name)
  end

  xscenario 'and must fill all fields' do

  end

  xscenario 'and start date must be less than end date' do

  end
  scenario 'successfully' do
    subsidiary = Subsidiary.create!(name: 'Almeidinha Cars',
                                    cnpj: '00000000000000',
                                    address: 'Alameda Santos, 1293')
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :employee)
    client = Client.create!(name: 'Fulano Sicrano', email: 'fulano@test.com',
                            cpf: '74334187099')
    category = CarCategory.create!(name: 'A', daily_rate: 30,
                                   car_insurance: 30, third_party_insurance: 30)
    manufacturer = Manufacturer.create!(name: 'Fiat')
    car_model = CarModel.create!(name: 'Onix', year: 2000,
                                 manufacturer: manufacturer, fuel_type: 'Flex',
                                 motorization: '1.0',
                                 car_category: category)
    car = Car.create!(car_model: car_model, license_plate: 'ABC1234',
                      color: 'Verde', mileage: 0, subsidiary: subsidiary)
    rental = Rental.create!(start_date: 1.day.from_now,
                            end_date: 2.days.from_now,
                            client: client, car_category: category)

    login_as(user, scope: :user)
    visit rental_path(rental)
    select "#{car.car_model.name} - #{car.license_plate}", from: 'Carro'
    click_on 'Iniciar Locação'

    expect(page).to have_content('Locação efetivada com sucesso!')
    expect(page).not_to have_button('Iniciar Locação')
    rental.reload
    car.reload
    expect(rental).to be_in_progress
    expect(car).not_to be_available
  end
end


# rental.reload - reload recarrega o banco de dados com o status atualizado do objeto