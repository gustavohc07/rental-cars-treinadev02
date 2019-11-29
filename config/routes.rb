Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers, only: [:index, :show]
  resources :subsidiaries, only: [:index, :show]
  resources :car_categories, only: [:index, :show]
end
