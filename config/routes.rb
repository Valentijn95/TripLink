Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get 'users', to: 'users#index'

end
