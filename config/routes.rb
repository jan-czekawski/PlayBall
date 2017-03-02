Rails.application.routes.draw do

  resources :users
	root "pages#index"
  resources :courts
  resources :comments, only: [:create, :update, :destroy, :edit]

  post "signup", to: "users#create"
  get "signup", to: "users#index"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
