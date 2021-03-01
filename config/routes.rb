require "sidekiq/web"

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(username),
    ::Digest::SHA256.hexdigest(Rails.application.credentials.sidekiq[:username]),
  ) & ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(password),
    ::Digest::SHA256.hexdigest(Rails.application.credentials.sidekiq[:password]),
  )
end

Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => "/admin/sidekiq"
  resource :software_button, only: %i[new create]
  resources :buttons, only: %i[show edit update] do
    member do
      get :report
      post :event
      get :all_my_buttons
      get :mode_report
    end
  end
  # resource :home do
  #   member do
  #     get :build
  #     get :server
  #   end
  # end
  get "/quotes/sample", to: "quotes#sample"
  get "/home/build", to: "home#build"
  get "/home/server", to: "home#server"

  get "test_root", to: "rails/welcome#index", as: "test_root_rails"

  post "/", to: "buttons#create"
  patch "/", to: "buttons#update"
  resources :home, only: [:index] do
    collection do
      get :old_index
    end
  end
  root to: "home#index"
end
