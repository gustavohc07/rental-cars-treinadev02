require 'rails_helper'

feature 'Admin register car into a fleet' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test', password: '123456', role: :admin)

    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

    Manufacturer.create!(name: 'Chevrolet')

    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Frota'
    click_on 'Clique aqui'

    fill_in 'Placa', with: 'HIA0045'
    fill_in 'Cor', with: 'Preto'
    fill_in 'Quilometragem', with: 27323
    select 'Prisma', from: 'Modelo'
    select 'Coringa', from: 'Filial'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Frota de veiculos')
    expect(page).to have_content('Modelo')
    expect(page).to have_content('Placa')
    expect(page).to have_content('Cor')
    expect(page).to have_content('Quilometragem')
    expect(page).to have_content('Prisma 1.4 Flex - 2018')
    expect(page).to have_content('HIA0045')
    expect(page).to have_content('Preto')
    expect(page).to have_content('27323')
    expect(page).to have_content('Coringa')
    expect(page).to have_content('Voltar')
  end

  scenario 'and must be admin' do
    user = User.create!(email: 'test@test', password: '123456')

    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

    Manufacturer.create!(name: 'Chevrolet')

    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    login_as(user, scope: :user)

    visit new_car_path

    expect(page).to have_content('Você não tem autorização!')
  end

  scenario 'and user must not see register buttons' do
    user = User.create!(email: 'test@test', password: '123456')

    login_as(user, scope: :user)
    visit cars_path

    expect(page).not_to have_content('Clique aqui')
  end

  scenario 'and user must not see register buttons if cars registered' do
    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

    Manufacturer.create!(name: 'Chevrolet')

    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    Car.create!(license_plate: 'ABC0001', color: 'Preto', mileage: 0, car_model_id: 1,
                subsidiary_id: 1)

    user = User.create!(email: 'test@test', password: '123456')

    login_as(user, scope: :user)
    visit cars_path

    expect(page).not_to have_content('Registrar novo veiculo')
  end
  scenario 'and must fill in all fields' do
    user = User.create!(email: 'test@test', password: '123456', role: :admin)

    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

    Manufacturer.create!(name: 'Chevrolet')

    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Frota'
    click_on 'Clique aqui'

    fill_in 'Placa', with: ''
    fill_in 'Cor', with: ''
    fill_in 'Quilometragem', with: 27323
    select 'Prisma', from: 'Modelo'
    select 'Coringa', from: 'Filial'

    click_on 'Enviar'


    expect(page).to have_content('nao deve ficar em branco')
  end
  scenario 'and mileage must be greater than or equal 0' do
    user = User.create!(email: 'test@test', password: '123456', role: :admin)

    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

    Manufacturer.create!(name: 'Chevrolet')

    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Frota'
    click_on 'Clique aqui'

    fill_in 'Placa', with: 'HIA3045'
    fill_in 'Cor', with: 'Preto'
    fill_in 'Quilometragem', with: -550
    select 'Prisma', from: 'Modelo'
    select 'Coringa', from: 'Filial'

    click_on 'Enviar'


    expect(page).to have_content('deve ser maior ou igual a 0')
  end

  scenario 'and license plate must be unique' do
    user = User.create!(email: 'test@test', password: '123456', role: :admin)

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
    visit root_path
    click_on 'Frota'
    click_on 'Registrar novo veiculo'

    fill_in 'Placa', with: 'ABC0001'
    fill_in 'Cor', with: 'Preto'
    fill_in 'Quilometragem', with: -550
    select 'Prisma', from: 'Modelo'
    select 'Coringa', from: 'Filial'

    click_on 'Enviar'


    expect(page).to have_content('ja existe no sistema!')
  end
end