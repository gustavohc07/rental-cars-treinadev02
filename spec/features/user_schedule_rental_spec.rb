require 'rails_helper'

feature 'User schedule rental' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :employee)
    client = Client.create!(name: 'Gustavo', email: 'gustavo@test.com',
                            cpf: '743.341.870-99')
    category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 40,
                                   third_party_insurance: 50)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    fill_in 'Data de início', with: 1.day.from_now.strftime('%d/%m/%Y')
    fill_in 'Data de fim', with: 2.days.from_now.strftime('%d/%m/%Y')
    select "#{client.name} - #{client.cpf}", from: 'Cliente'
    select category.name, from: 'Categoria do Carro'
    click_on 'Enviar'

    expect(page).to have_content('Locação agendada com sucesso')
    expect(page).to have_content("Data de início: #{1.day.from_now.strftime('%d/%m/%Y')}")
    expect(page).to have_content("Data de fim: #{2.days.from_now.strftime('%d/%m/%Y')}")
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
    expect(page).to have_content('Categoria')
    expect(page).to have_content(category.name)
  end

  xscenario 'and must fill all fields' do

  end

  xscenario 'and start date must be less than end date' do

  end
end