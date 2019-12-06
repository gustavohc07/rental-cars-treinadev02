require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully without any manufacturers registered' do
    user = User.create!(email: 'test@test.com', password: '123456', admin: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'clique aqui'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
  end

  scenario 'and successfully with manufacturers registered' do
    Manufacturer.create!(name: 'Fiat')
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)

    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Chevrolet'
    click_on 'Enviar'

    expect(page).to have_content('Chevrolet')
  end
  scenario 'and do not create but return to manufacturers page' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'clique aqui'
    click_on 'Voltar'

    expect(current_path).to eq manufacturers_path
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit new_manufacturer_path
    fill_in 'Nome', with: '' # poderia ter pulado essa etapa, pois o form vem vazio
                             # quando algo novo esta sendo criado.
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end 

  scenario 'and name must be unique' do
    Manufacturer.create(name: 'Fiat')
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)

    visit new_manufacturer_path
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Name já está em uso')
  end
  scenario 'and must be logged in' do
    visit new_manufacturer_path

    expect(current_path).to eq new_user_session_path
  end
end