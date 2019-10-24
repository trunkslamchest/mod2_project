Rails.application.routes.draw do

  resources :favorites
	resources :comps
	resources :reports
	resources :properties, only: [:show, :new, :create]
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]


  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  root to: 'users#index'
end
