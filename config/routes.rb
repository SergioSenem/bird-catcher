Rails.application.routes.draw do

  resources :users, only: [:new, :create] do
  	resources :hashtags
  end
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  root 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
