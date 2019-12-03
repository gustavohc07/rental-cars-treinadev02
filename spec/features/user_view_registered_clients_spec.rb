require 'rails_helper'

feature 'User view registered clients' do
  scenario 'successfully' do
    Client.create!(name: 'Gustavo', email: 'abobrinha@abobrinha.com',
                   cpf: '123.456.789-10')

    visit root_path
    click_on 'Usuários registrados'

    expect(page).to have_content('Lista de usuários')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Email')
    expect(page).to have_content('CPF')
    expect(page).to have_content('Gustavo')
    expect(page).to have_content('abobrinha@abobrinha.com')
    expect(page).to have_content('123.456.789-10')
  end
  scenario 'and there are no registered clients' do
    visit root_path
    click_on 'Usuários registrados'

    expect(page).to have_content('Não existem usuários cadastrados. Clique aqui para cadastrar um novo usuário.')
    expect(page).to have_link('Clique aqui')
  end
end