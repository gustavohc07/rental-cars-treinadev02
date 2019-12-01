require 'rails_helper'

feature 'Admin register car category' do
  scenario 'successfully without any car category registered' do
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Clique aqui'

    fill_in 'Nome da categoria', with: 'Sedan'
    fill_in 'Valor da diária', with: '100'
    fill_in 'Valor do seguro', with: '50'
    fill_in 'Seguro contra terceiros', with: '35'
    click_on 'Enviar'

    expect(page).to have_content('Sedan')
    expect(page).to have_content('R$ 100.0')
    expect(page).to have_content('R$ 50.0')
    expect(page).to have_content('R$ 35.0')
    expect(page).to have_content('Total : R$ 185.0')
  end

  scenario 'and with car registered on database' do
    CarCategory.create(name:'Sedan', daily_rate: 100, car_insurance: 50, third_party_insurance: 50)

    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Cadastrar nova categoria'

    fill_in 'Nome da categoria', with: 'SUV'
    fill_in 'Valor da diária', with: '150'
    fill_in 'Valor do seguro', with: '80'
    fill_in 'Seguro contra terceiros', with: '70'
    click_on 'Enviar'

    expect(page).to have_content('SUV')
    expect(page).to have_content('R$ 150.0')
    expect(page).to have_content('R$ 80.0')
    expect(page).to have_content('R$ 70.0')
    expect(page).to have_content('Total : R$ 300.0')
  end

  scenario 'and do not create but return to car categories page' do
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Clique aqui'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end
end
