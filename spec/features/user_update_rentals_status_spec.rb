require 'rails_helper'

feature 'User can update rental status' do
  scenario 'successfully scheduled' do
    user = User.create!(email: 'test@test.com', password: '123456')
    client = Client.create!(name: 'Gustavo', email: 'gustavo@test.com',
                            cpf: '743.341.870-99')
    category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 40,
                                   third_party_insurance: 50)
    Rental.create!(start_date: 1.day.from_now.strftime('%d/%m/%Y'),
                   end_date: 2.days.from_now.strftime('%d/%m/%Y'),
                   client: client,
                   car_category: category,
                   status: :in_progress)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    click_on 'Efetivar'

    expect(page).to have_content('Locação efetivada com sucesso!')
    expect(page).to have_content('Status')
    expect(page).to have_content('Efetivada')
    expect(page).to have_link('Cancelar')
  end

  scenario 'successfully cancel scheduled rental' do
    user = User.create!(email: 'test@test.com', password: '123456')
    client = Client.create!(name: 'Gustavo', email: 'gustavo@test.com',
                            cpf: '743.341.870-99')
    category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 40,
                                   third_party_insurance: 50)
    Rental.create!(start_date: 1.day.from_now.strftime('%d/%m/%Y'),
                   end_date: 2.days.from_now.strftime('%d/%m/%Y'),
                   client: client,
                   car_category: category,
                   status: :scheduled)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    click_on 'Cancelar'

    expect(page).to have_content('Locação cancelada!')
    expect(page).to have_content('Cancelada')
  end
  scenario 'must be logged in' do
    visit new_rental_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'must be logged in to access view path' do
    visit rentals_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end