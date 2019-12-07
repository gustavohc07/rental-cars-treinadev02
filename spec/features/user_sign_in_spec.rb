require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com',
                        password: '123456')

    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(current_path).to eq root_path
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
  end
  scenario 'and logout' do
    user = User.create!(email: 'teste@teste.com',
                        password: '123456')

    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'
    click_on 'Sair'

    expect(page).to have_content('Signed out successfully')
    expect(current_path).to eq root_path
    expect(page).not_to have_link('Sair')
    expect(page).to have_link('Entrar')
  end
end