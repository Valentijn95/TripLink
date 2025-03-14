Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  post "/", to: "pages#home_search"

  get "profile", to: "pages#profile", as: 'profile'

  get "/search", to: "pages#render_location_partial", as: :location_partial
  get "/search/delete", to: "pages#render_empty_location_partial", as: :empty_loacation_partial

  resources :users, only: [:index, :show]

   get 'matches/new/:guide_id', to: 'matches#new', as: 'new_match'

  resources :matches, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
