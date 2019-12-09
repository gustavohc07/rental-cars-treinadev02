require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully without any subsidiary registered' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Clique aqui'

    fill_in 'Nome', with: 'SmartCar'
    fill_in 'CNPJ', with: '00000000000100'
    fill_in 'Endereço', with: 'Rua Professor Euler, Numero 327, CEP 00000-00'
    click_on "Enviar"

    expect(page).to have_content('SmartCar')
    expect(page).to have_content('00.000.000/0001-00')
    expect(page).to have_content('Rua Professor Euler, Numero 327, CEP 00000-00')
  end

  scenario 'successfully with subsidiary registered' do
    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910000',
                      address: 'Rua Golveia, Numero 1250, Bairro Santao Amaro')
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'

    fill_in 'Nome', with: 'SmartCar'
    fill_in 'CNPJ', with: '00000000000100'
    fill_in 'Endereço', with: 'Rua Professor Euler, Numero 327, CEP 00000-00'
    click_on "Enviar"

    expect(page).to have_content('SmartCar')
    expect(page).to have_content('00.000.000/0001-00')
    expect(page).to have_content('Rua Professor Euler, Numero 327, CEP 00000-00')
  end

  scenario 'and fill in all field' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit new_subsidiary_path
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
    expect(page).to have_content('não deve ficar em branco.')
  end

  scenario 'and enter a valid CNPJ' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit new_subsidiary_path
    fill_in "CNPJ", with: '1234.'
    click_on 'Enviar'

    expect(page).to have_content('deve conter 14 caracteres')
    expect(page).to have_content('deve conter apenas números')
  end

  scenario 'and CNPJ must be unique' do
    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910000',
                       address: 'Rua Golveia, Numero 1250, Bairro Santao Amaro')
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)

    visit new_subsidiary_path
    fill_in 'Nome', with: 'Stock rent car'
    fill_in 'CNPJ', with: '12345678910000'
    fill_in 'Nome', with: 'Rua Borba Gato, Numero 500, Bairro Santao Amaro'
    click_on 'Enviar'

    expect(page).to have_content('já existe!')
  end

  scenario 'and do not create but return to subsidiaries page' do
    user = User.create!(email: 'test@test.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Clique aqui'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
  scenario 'and must be logged in as admin' do
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit new_subsidiary_path

    expect(page).to have_content('Você não tem autorização!')

  end
  scenario 'and must be logged in' do
    visit new_subsidiary_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and user do not see register button' do
    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit subsidiaries_path

    expect(page).not_to have_content('Clique aqui')
  end

  scenario 'and user do not see register button if subsidiary registered already' do
    user = User.create!(email: 'test@test.com', password: '123456')
    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910000',
                       address: 'Rua Golveia, Numero 1250, Bairro Santao Amaro')

    login_as(user, scope: :user)
    visit subsidiaries_path

    expect(page).not_to have_content('Registrar nova filial')
  end
end