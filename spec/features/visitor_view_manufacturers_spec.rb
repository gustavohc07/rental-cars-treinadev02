require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  scenario 'and there are no manufacturers registered' do
    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_content('Não ha fabricantes cadastrados no sistema, clique aqui para cadastrar um novo fabricante.')
    expect(page).to have_link('clique aqui')

  end

  scenario 'and return to manufacturers page' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq manufacturers_path
  end

  scenario 'and return to home page' do
    visit root_path
    click_on 'Fabricantes'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end