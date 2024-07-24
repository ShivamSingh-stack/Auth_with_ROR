Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/secret'
  resources :users, only: [:index, :new, :create, :destroy]
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :articles
  # resources :user_sessions, only: [:new, :create, :destroy]

  # get 'users/index'
  # get 'users/new'
  # get 'users/create'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
