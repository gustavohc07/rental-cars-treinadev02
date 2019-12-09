require 'rails_helper'

xfeature 'Admin edit car' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test', password: '123456')

    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)

    Manufacturer.create!(name: 'Chevrolet')
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)
    car = Car.create!(license_plate: 'ABC0001', color: 'Preto', mileage: 0, car_model_id: 1,
                subsidiary_id: 1)

    login_as(user, scope: :user)
    visit edit_car_path(car)

    fill_in 'Placa', with: 'HIA0045'
    fill_in 'Cor', with: 'Preto'
    fill_in 'Quilometragem', with: 27323
    select 'Palio', from: 'Modelo'
    select 'Best', from: 'Filial'

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
end