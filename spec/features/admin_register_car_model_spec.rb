require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)
    Manufacturer.create!(name: 'Chevrolet')
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 200, car_insurance: 150,
                        third_party_insurance: 190)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Clique aqui'

    fill_in 'Nome', with: 'Onix'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Combustível', with: 'Flex'
    select 'Chevrolet', from: 'Fabricante'
    select 'A', from: 'Categoria'

    click_on 'Enviar'

    expect(page).to have_content('Modelo registrado com sucesso')
    expect(page).to have_css('h1', text: 'Onix')
    expect(page).to have_content('Ano: 2020')
    expect(page).to have_content('Fabricante: Chevrolet')
    expect(page).to have_content('Categoria: A')
  end

  scenario 'and do not register but wants to go back to car models page' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Clique aqui'
    click_on 'Voltar'

    expect(current_path).to eq car_models_path
  end

  scenario 'and must be admin' do
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit new_car_model_path

    expect(page).to have_content('Você não tem autorização!')
  end

  scenario 'and must be logged in' do
    visit new_car_model_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and user do not see register button' do
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit car_models_path

    expect(page).not_to have_content('Clique aqui')
  end
  scenario 'and user do not see register button if car model already registered' do
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 200, car_insurance: 150,
                        third_party_insurance: 190)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit car_models_path

    expect(page).not_to have_content('Registrar novo modelo')
  end
end