require 'rails_helper'

feature 'Admin edit car model' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)
    Manufacturer.create!(name: 'Chevrolet')
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 200, car_insurance: 150,
                        third_party_insurance: 190)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Prisma'
    click_on 'Editar'

    fill_in 'Nome', with: 'Onix'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Combustível', with: 'Flex'
    select 'Chevrolet', from: 'Fabricante'
    select 'B', from: 'Categoria'

    click_on 'Enviar'
  end
  scenario 'and must be logged in' do
    Manufacturer.create!(name: 'Chevrolet')
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 200, car_insurance: 150,
                        third_party_insurance: 190)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    visit edit_car_model_path(1)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and must be admin' do
    user = User.create!(email: 'test@test.com', password: '123456')
    Manufacturer.create!(name: 'Chevrolet')
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 200, car_insurance: 150,
                        third_party_insurance: 190)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    login_as(user, scope: :user)
    visit edit_car_model_path(1)

    expect(page).to have_content('Você não tem autorização!')
  end
  scenario 'and user must not see edit link' do
    user = User.create!(email: 'test@test.com', password: '123456')
    Manufacturer.create!(name: 'Chevrolet')
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 200, car_insurance: 150,
                        third_party_insurance: 190)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    login_as(user, scope: :user)
    visit car_model_path(1)

    expect(page).not_to have_content('Editar')
    expect(page).to have_content('Voltar')
  end
end