Rails.application.routes.draw do
  resources :favorites
	resources :comps
	resources :reports
	resources :properties
	resources :users
end
