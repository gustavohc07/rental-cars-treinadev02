require 'rails_helper'

feature 'Visitor view registered car models' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Chevrolet')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    visit root_path
    click_on 'Modelos de Carros'

    expect(page).to have_content('Modelo')
    expect(page).to have_content('Ano')
    expect(page).to have_content('Motor')
    expect(page).to have_content('Combustivel')
    expect(page).to have_content('Fabricante')

    expect(page).to have_content('Prisma')
    expect(page).to have_content('2018')
    expect(page).to have_content('1.4')
    expect(page).to have_content('Flex')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_link('Prisma')
  end
  scenario 'and view car model in manufacturer' do
    Manufacturer.create!(name: 'Chevrolet')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    visit root_path
    click_on 'Fabricante'
    click_on 'Chevrolet'

    expect(page).to have_content('Modelo')
    expect(page).to have_content('Combustivel')
    expect(page).to have_content('Motor')
    expect(page).to have_content('Ano')

    expect(page).to have_content('Prisma')
    expect(page).to have_content('Flex')
    expect(page).to have_content('1.4')
    expect(page).to have_content('2018')
    expect(page).to have_link('Prisma')
  end
  scenario 'and view car model in car categories' do
    Manufacturer.create!(name: 'Chevrolet')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    visit root_path
    click_on 'Categoria de Carros'
    click_on 'A'

    expect(page).to have_content('Modelo')
    expect(page).to have_content('Combustivel')
    expect(page).to have_content('Motor')
    expect(page).to have_content('Ano')

    expect(page).to have_content('Prisma')
    expect(page).to have_content('Flex')
    expect(page).to have_content('1.4')
    expect(page).to have_content('2018')
    expect(page).to have_link('Prisma')
  end
  scenario 'and go to the manufacturer page' do
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Prisma'
    click_on "Ir para o fabricante Chevrolet"

    expect(current_path).to eq manufacturer_path(manufacturer)
  end

  scenario 'and go to the category page' do
    Manufacturer.create!(name: 'Chevrolet')
    category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 90)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Prisma'
    click_on "Ir para a categoria A"

    expect(current_path).to eq car_category_path(category)
  end

  scenario 'and return to car models page' do
    Manufacturer.create!(name: 'Chevrolet')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 50,
                                   third_party_insurance: 90)
    CarModel.create!(name: 'Prisma', fuel_type: 'Flex', motorization: '1.4',
                     year: 2018, manufacturer_id: 1, car_category_id: 1)

    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Prisma'
    click_on 'Voltar'

    expect(current_path).to eq car_models_path
  end

  scenario 'and return to home page' do
    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

end