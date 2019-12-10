Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers, only: [:index, :show, :new, :create, :edit, :update]
  resources :subsidiaries
  resources :car_categories, only: [:index, :show, :new, :create, :edit, :update]
  resources :clients, only: [:index, :new, :create]
  resources :car_models, only: [:index, :show, :new, :create, :edit, :update]
  resources :cars, only: [:index, :show, :new, :create, :edit, :update]
  resources :rentals, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
    member do
      post 'activate'
      post 'cancel'
    end
  end
  
end
