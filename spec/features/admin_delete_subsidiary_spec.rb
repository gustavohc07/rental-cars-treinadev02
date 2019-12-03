require 'rails_helper'

feature 'Admin delete subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                                    address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    visit root_path
    click_on 'Filiais'
    click_on 'Coringa'
    click_on 'Excluir'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Não existem filiais cadastradas no sistema. Clique aqui para cadastrar uma nova filial.')
  end

  scenario 'and successfully with another registered subsidiary' do
    Subsidiary.create!(name: 'Bento', cnpj: '12345678910001',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')
    Subsidiary.create!(name: 'Coringa 2.0', cnpj: '12345678910002',
                       address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    visit root_path
    click_on 'Filiais'
    click_on 'Bento'
    click_on 'Excluir'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_no_link('Bento')
  end
end