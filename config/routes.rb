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

flipper_app = Flipper::UI.app(Flipper.instance) do |builder|
  builder.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(username),
      ::Digest::SHA256.hexdigest(Rails.application.credentials.flipper[:username]),
    ) & ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(password),
      ::Digest::SHA256.hexdigest(Rails.application.credentials.flipper[:password]),
    )
  end
end

Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :modes
      resources :buttons
      resources :events

      root to: "users#index"
    end
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
  }

  mount Sidekiq::Web => "/admin/sidekiq"

  mount flipper_app, at: '/flipper'

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
