Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "posts#index"
  delete "logout", to: "sessions#destroy"

  resources :sessions, only: %i(new create)
  resources :registrations, only: %i(new create)
  resources :passwords, only: %i(edit update)
  resources :users, only: %i(show)
  resources :posts do
    resources :comments, shallow: true
  end
end
