Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  post "/", to: "pages#home_search"

  get "profile", to: "pages#profile", as: 'profile'

  get "/search", to: "pages#render_location_partial", as: :location_partial
  get "/search/delete", to: "pages#render_empty_location_partial", as: :empty_loacation_partial

  resources :users, only: [:index, :show] do
    resources :matches, only: [:new, :create]
  end

  get 'matches/new', to: 'matches#new', as: 'new_match'

  resources :matches, only: [:index, :show, :new] do
    resources :messages, only: [:create]
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
