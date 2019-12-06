require "rails_helper"

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                      address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Coringa'
    click_on 'Editar'

    fill_in 'Nome', with: 'Coringa 2.0'
    fill_in 'CNPJ', with: '12345678910001'
    fill_in 'Endereço', with: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25'
    click_on 'Enviar'

    expect(page).to have_content('Coringa 2.0')
    expect(page).to have_content('12.345.678/9100-01')
    expect(page).to have_content('Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

  end

  scenario 'and fill in all field' do
    subsidiary = Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit edit_subsidiary_path(subsidiary)
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
    expect(page).to have_content('não deve ficar em branco.')
  end

  scenario 'and enter a valid CNPJ' do
    subsidiary = Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                                    address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit edit_subsidiary_path(subsidiary)
    fill_in "CNPJ", with: '1234.'
    click_on 'Enviar'

    expect(page).to have_content('deve conter 14 caracteres')
    expect(page).to have_content('deve conter apenas números')
  end

  scenario 'and CNPJ must be unique' do
    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                                    address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')
    subsidiary = Subsidiary.create!(name: 'Coringa 2.0', cnpj: '12345678910002',
                                    address: 'Rua Borba Gato, Bairro Santo Amaro, CEP 12345-678, Numero 25')


    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit edit_subsidiary_path(subsidiary)
    fill_in 'CNPJ', with: '12345678910001'
    click_on 'Enviar'

    expect(page).to have_content('já existe!')
  end

  scenario 'and may go back to subsidiary page' do
    subsidiary = Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    user = User.create!(email: 'test@test.com', password: '123456')

    login_as(user, scope: :user)
    visit edit_subsidiary_path(subsidiary)
    click_on 'Voltar'

    expect(current_path).to eq subsidiary_path(subsidiary)
  end
end