require "sidekiq/web"

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :software_button, only: %i[new create]
  resources :buttons, only: %i[show edit update] do
    member do
      get :report
      post :event
      get :all_my_buttons
    end
  end

  get "test_root", to: "rails/welcome#index", as: "test_root_rails"

  post "/", to: "buttons#create"
  patch "/", to: "buttons#update"
  root to: "home#index"
end
