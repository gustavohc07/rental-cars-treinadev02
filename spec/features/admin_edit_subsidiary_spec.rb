require "rails_helper"

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    Subsidiary.create(name: 'Coringa', cnpj: '12345678910001',
                      address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    visit root_path
    click_on 'Filiais'
    click_on 'Coringa'
    click_on 'Editar'

    fill_in 'Nome', with: 'Coringa 2.0'
    fill_in 'CNPJ', with: '12345678910001'
    fill_in 'Endereço', with: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25'
    click_on 'Enviar'

    expect(page).to have_content('Coringa 2.0')
    expect(page).to have_content('12345678910001')
    expect(page).to have_content('Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

  end
end