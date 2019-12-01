require 'rails_helper'

feature 'Visitor View Subsidiaries' do
  scenario "successfully" do
    subsidiary = Subsidiary.create(name: 'Coringa', cnpj: '12345678910001', address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_css('h1', text: "Filiais")
    expect(page).to have_css('li', text: subsidiary.name)
    expect(page).to have_link(subsidiary.name)
    expect(page).to have_link('Voltar')
  end

  scenario 'and view subsidiary' do
    subsidiary = Subsidiary.create(name: 'Coringa', cnpj: '12345678910001', address: 'Rua Augusta, Bairro Santa Monica, CEP 12345-678, Numero 25')

    visit root_path
    click_on 'Filiais'
    click_on 'Coringa'

    expect(page).to have_css('h1', text: subsidiary.name)
    expect(page).to have_css('p', text: subsidiary.cnpj)
    expect(page).to have_css('p', text: subsidiary.address)
    expect(page).to have_link('Voltar')
  end

  scenario 'and subsidiaries are not registered' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Não existem filiais cadastradas no sistema')
  end
end

