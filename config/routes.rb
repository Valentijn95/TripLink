Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  post "/", to: "pages#home_search"

  get "profile", to: "pages#profile", as: 'profile'

  get "/search", to: "pages#render_location_partial", as: :location_partial
  get "/search/delete", to: "pages#render_empty_location_partial", as: :empty_loacation_partial

  get "/api/autocomplete", to: "api#fetch_autocomplete_data", as: :fetch_autocomplete_data

  post "/matches/:id/finish", to: "matches#finish", as: :finish_match
  post "/matches/:id/end", to: "matches#end", as: :end_match

  get "/profile/:id/new_guide", to: "pages#new_guide", as: :new_guide
  put "/profile/:id/create_guide", to: "pages#apply_guide", as: :apply_guide

  resources :users, only: [:index, :show]

  resources :matches, only: [:new, :create, :destroy]



  resources :matches, only: [:index, :show, :new, :update] do
    resources :reviews, only: [:new, :create]
    resources :messages, only: [:create]
  end

  post "/profile/add_interest", to: "pages#add_interest", as: :add_interest
  delete "/profile/remove_interest", to: "pages#remove_interest", as: :remove_interest

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
