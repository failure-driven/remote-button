Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :software_buttons, only: %i[new create]

  root to: "rails/welcome#index"
end
