require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456')
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  scenario 'and there are no manufacturers registered' do
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_content('Não ha fabricantes cadastrados no sistema.')
    expect(page).not_to have_link('clique aqui')
  end

  scenario 'and return to manufacturers page' do
    user = User.create!(email: 'test@test.com', password: '123456')
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq manufacturers_path
  end

  scenario 'and return to home page' do
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and must be logged in' do
    visit manufacturers_path

    expect(current_path).to eq new_user_session_path
  end
end