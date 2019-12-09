require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
    expect(page).to have_content('Fabricante atualizado com sucesso')
  end

  scenario 'and must fill in all fields' do
    Manufacturer.create!(name: 'Fiat')

    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end 

  scenario 'and name must be unique' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')

    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'
  
    expect(page).to have_content('Name já está em uso')
  end

  scenario 'and may go back to manufacturer page' do
    manufacturer = Manufacturer.create!(name: 'Fiat')
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    click_on 'Voltar'

    expect(current_path).to eq manufacturer_path(manufacturer)
  end
  scenario 'and must be logged in' do
    manufacturer = Manufacturer.create!(name: 'Fiat')

    visit edit_manufacturer_path(manufacturer)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and must be authenticated admin to edit' do
    user = User.create!(email: 'test@test.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Fiat')

    login_as(user, scope: :user)
    visit edit_manufacturer_path(manufacturer)

    expect(page).to have_content('Você não tem autorização!')
  end

  scenario 'and must not see edit link' do
    user = User.create!(email: 'test@test.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Fiat')

    login_as(user, scope: :user)
    visit manufacturer_path(manufacturer)

    expect(page).not_to have_content('Editar Fabricante')
  end
end