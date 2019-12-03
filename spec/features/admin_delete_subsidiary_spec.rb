require 'rails_helper'

feature 'Admin delete subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                                    address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    visit root_path
    click_on 'Filiais'
    click_on 'Coringa'
    click_on 'Excluir'

    expect(page).to have_content('Não existem filiais cadastradas no sistema. Clique aqui para cadastrar uma nova filial.')
  end
end