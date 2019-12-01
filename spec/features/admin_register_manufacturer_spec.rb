require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully without any manufacturers registered' do
    visit root_path
    click_on 'Fabricantes'
    click_on 'clique aqui'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
  end

  scenario 'and successfully with manufacturers registered' do
    Manufacturer.create(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Chevrolet'
    click_on 'Enviar'

    expect(page).to have_content('Chevrolet')
  end
  scenario 'and do not create but return to manufacturers page' do
    visit root_path
    click_on 'Fabricantes'
    click_on 'clique aqui'
    click_on 'Voltar'

    expect(current_path).to eq manufacturers_path
  end
end