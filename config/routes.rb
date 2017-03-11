Rails.application.routes.draw do


	root "pages#index"
  post "signup", to: "users#create"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users
  resources :courts
  resources :comments, only: [:create, :destroy, :update]
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
