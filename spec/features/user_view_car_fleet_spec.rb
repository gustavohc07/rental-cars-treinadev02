require 'rails_helper'

feature 'User view car fleet' do
  scenario 'successfully if user is not admin' do
    user = User.create!(email: 'teste@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Frota'

    expect(page).to have_content('Não existem frotas de veículos cadastradas.')
  end

  scenario 'sucessfully if user is admin' do
    user = User.create!(email: 'teste@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Frota'

    expect(page).to have_content('Não existem frotas de veículos cadastradas. Clique aqui para cadastrar um novo veículo para a frota')
  end

  scenario 'and user, admin or not, can see car fleet' do
    user = User.create!(email: 'test@test', password: '123456')

    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

    Manufacturer.create!(name: 'Chevrolet')
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)
    Car.create!(license_plate: 'ABC0001', color: 'Preto', mileage: 0, car_model_id: 1,
                subsidiary_id: 1)

    login_as(user, scope: :user)
    visit cars_path

    expect(page).to have_content('Modelo')
    expect(page).to have_content('Placa')
    expect(page).to have_content('Quilometragem')
    expect(page).to have_content('Filial')
    expect(page).to have_content('Prisma 1.4 Flex - 2018')
    expect(page).to have_content('')
    expect(page).to have_content('Quilometragem')
    expect(page).to have_content('Filial')
  end

  scenario 'and can view subsidiary fleet, admin or not' do
    user = User.create!(email: 'test@test', password: '123456')

    subsidiary = Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                                    address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_model = CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                                 year: 2018, manufacturer: manufacturer,
                                 car_category: car_category)
    Car.create!(license_plate: 'ABC0001', color: 'Preto', mileage: 0, car_model: car_model,
                subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit cars_path
    click_on 'Coringa'

    expect(page).to have_css('h1', text: 'Frota de veiculos da filial Coringa')
    expect(page).to have_content('Modelo')
    expect(page).to have_content('Placa')
    expect(page).to have_content('Cor')
    expect(page).to have_content('Quilometragem')
    expect(page).to have_content('Prisma 1.4 Flex - 2018')
    expect(page).to have_content('ABC0001')
    expect(page).to have_content('Preto')
    expect(page).to have_content("0")
    expect(page).to have_content('Voltar')
  end

  scenario 'and can go to subsidiary page' do
    user = User.create!(email: 'test@test', password: '123456')

    subsidiary = Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                                    address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

    Manufacturer.create!(name: 'Chevrolet')
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)
    car = Car.create!(license_plate: 'ABC0001', color: 'Preto', mileage: 0, car_model_id: 1,
                      subsidiary_id: 1)

    login_as(user, scope: :user)
    visit car_path(car)
    click_on 'Ir para pagina da filial'

    expect(current_path).to eq subsidiary_path(subsidiary)
    expect(page).to have_content('Coringa')
  end
  
  scenario 'and must be logged in' do
    visit cars_path

    expect(current_path).to eq new_user_session_path
  end
end