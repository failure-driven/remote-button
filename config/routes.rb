Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :software_buttons, only: %i[new create]
  # resources :buttons, only: %i[create]

  get "test_root", to: "rails/welcome#index", as: "test_root_rails"
  post "/", to: "buttons#create"
  root to: "home#index"
end
