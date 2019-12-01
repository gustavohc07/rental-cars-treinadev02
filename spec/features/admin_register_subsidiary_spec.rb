require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully without any subsidiary registered' do
    visit root_path
    click_on 'Filiais'
    click_on 'Clique aqui'

    fill_in 'Nome', with: 'SmartCar'
    fill_in 'CNPJ', with: '00.000.000/0001-00'
    fill_in 'Endereço', with: 'Rua Professor Euler, Numero 327, CEP 00000-00'
    click_on "Enviar"
  end

  scenario 'successfully with subsidiary registered' do
    Subsidiary.create(name: 'Coringa', cnpj: '1234567891000',
                      address: 'Rua Golveia, Numero 1250, Bairro Santao Amaro')

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'

    fill_in 'Nome', with: 'SmartCar'
    fill_in 'CNPJ', with: '00.000.000/0001-00'
    fill_in 'Endereço', with: 'Rua Professor Euler, Numero 327, CEP 00000-00'
    click_on "Enviar"
  end

  scenario 'and do not create but return to subsidiaries page' do
    visit root_path
    click_on 'Filiais'
    click_on 'Clique aqui'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end