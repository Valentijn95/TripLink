Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "/search", to: "pages#render_location_info", as: :render_location_info
  get "/search/delete", to: "pages#remove_location_info", as: :remove_location_info

  resources :users, only: [:index, :show]

  resources :matches, only: [:show] do
    member do
      get 'chat'
      post 'send_message'
    end
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
