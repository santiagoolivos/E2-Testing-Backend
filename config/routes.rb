# frozen_string_literal: true

Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#login'

  resources :airports
  resources :flights do
    resources :seats
  end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
