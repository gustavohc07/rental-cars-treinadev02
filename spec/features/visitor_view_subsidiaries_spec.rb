require 'rails_helper'

feature 'Visitor View Subsidiaries' do
  scenario 'successfully' do
    subsidiary = Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                                   address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_css('h1', text: 'Filiais')
    expect(page).to have_css('li', text: subsidiary.name)
    expect(page).to have_link(subsidiary.name)
    expect(page).to have_link('Voltar')
  end

  scenario 'and view subsidiary' do
    subsidiary = Subsidiary.create!(name: 'Coringa', cnpj: '12345678910001',
                                   address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    visit root_path
    click_on 'Filiais'
    click_on 'Coringa'

    expect(page).to have_css('h1', text: subsidiary.name)
    expect(page).to have_css('p', text: '12.345.678/9100-01')
    expect(page).to have_css('p', text: subsidiary.address)
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create(name: 'Coringa', cnpj: '12345678910001',
                      address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    visit root_path
    click_on 'Filiais'
    click_on 'Coringa'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end

  scenario 'and return to home page' do
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and subsidiaries are not registered' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Não existem filiais cadastradas no sistema. Clique aqui para cadastrar uma nova filial.')
  end
end