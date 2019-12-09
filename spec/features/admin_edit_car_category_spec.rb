require "rails_helper"

feature 'Admin edit car car_category' do
  scenario 'successfully' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100, car_insurance: 50, third_party_insurance: 50)
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categoria de Carros'
    click_on 'Sedan'
    click_on 'Editar Categoria'
    fill_in 'Nome', with: 'A - Econômico'
    fill_in 'Valor da diária', with: 70
    fill_in 'Valor do seguro', with: 35
    fill_in 'Seguro contra terceiros', with: 40
    click_on 'Enviar'

    expect(page).to have_content('A - Econômico')
    expect(page).to have_content('R$ 70.0')
    expect(page).to have_content('R$ 35.0')
    expect(page).to have_content('R$ 40.0')
    expect(page).to have_content('R$ 145.0')
  end
  scenario 'and may go back to car category page' do
    category = CarCategory.create!(name: 'Sedan', daily_rate: 100, car_insurance: 50, third_party_insurance: 50)
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categoria de Carros'
    click_on 'Sedan'
    click_on 'Editar Categoria'
    click_on 'Voltar'

    expect(current_path).to eq car_category_path(category)
  end
  scenario 'and must be logged in' do
    category = CarCategory.create!(name: 'Sedan', daily_rate: 100, car_insurance: 50, third_party_insurance: 50)

    visit edit_car_category_path(category)

    expect(current_path).to eq new_user_session_path
  end
  scenario 'and must be admin' do
    category = CarCategory.create!(name: 'Sedan', daily_rate: 100, car_insurance: 50, third_party_insurance: 50)
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit edit_car_category_path(category)

    expect(page).to have_content('Você não tem autorização!')
  end
  scenario 'and user must not see edit button' do
    CarCategory.create!(name: 'Sedan', daily_rate: 100, car_insurance: 50, third_party_insurance: 50)
    user = User.create!(email: 'test@test', password: '123456')

    login_as(user, scope: :user)
    visit car_categories_path
    click_on 'Sedan'

    expect(page).not_to have_content('Editar Categoria')
  end
end