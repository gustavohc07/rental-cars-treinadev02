require "rails_helper"

feature 'User register new client' do
  scenario 'successfully' do
    visit root_path
    click_on 'Usuários registrados'
    click_on 'Clique aqui'
    fill_in 'Nome', with: 'Gustavo'
    fill_in 'Email', with: 'abobrinha@abobrinha.com'
    fill_in 'CPF', with: '12345678910'
    click_on 'Enviar'

    expect(page).to have_content('Lista de usuários')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Email')
    expect(page).to have_content('CPF')
    expect(page).to have_content('Gustavo')
    expect(page).to have_content('abobrinha@abobrinha.com')
    expect(page).to have_content('123.456.789-10')
  end

  scenario 'and successfully register with another client already in database' do
    Client.create!(name: 'Gustavo', email: 'abobrinha@abobrinha.com',
                   cpf: '12345678910')

    visit new_client_path
    fill_in 'Nome', with: 'Henrique'
    fill_in 'Email', with: 'abobrinha2@abobrinha.com'
    fill_in 'CPF', with: '12345678911'
    click_on 'Enviar'

    expect(page).to have_content('Lista de usuários')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Email')
    expect(page).to have_content('CPF')
    expect(page).to have_content('Gustavo')
    expect(page).to have_content('abobrinha@abobrinha.com')
    expect(page).to have_content('123.456.789-10')
    expect(page).to have_content('Henrique')
    expect(page).to have_content('abobrinha2@abobrinha.com')
    expect(page).to have_content('123.456.789-11')
  end

  scenario 'and do not register but go back to clients page' do
    visit new_client_path
    click_on 'Voltar'

    expect(current_path).to eq clients_path
  end
end