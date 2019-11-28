require 'rails_helper'

feature 'Visitor View Car Categories' do
  scenario 'successfully' do
    car_category = CarCategory.create(name: 'Sedan', daily_rate: 24.5,
                                      car_insurance: 12.5,
                                      third_party_insurance: 17.5)
    visit root_path
    click_on 'Categorias de Carros'

    expect(page).to have_css('h1', text: 'Categorias de Carros')
    expect(page).to have_css('li', text: car_category.name)
    expect(page).to have_link(car_category.name)
    expect(page).to have_link('Voltar')
  end

  scenario 'and view car category details' do
    car_category = CarCategory.create(name: 'Sedan', daily_rate: 24.5,
                                      car_insurance: 12.5,
                                      third_party_insurance: 17.5)
    visit root_path
    click_on 'Categorias de Carros'
    click_on car_category.name

    expect(page).to have_css('h1', text: car_category.name)
    expect(page).to have_content(car_category.daily_rate)
    expect(page).to have_content(car_category.car_insurance)
    expect(page).to have_content(car_category.third_party_insurance)
    expect(page).to have_link('Voltar')
  end
end