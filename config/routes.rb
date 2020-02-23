Rails.application.routes.draw do

  resources :users do
  	resources :hashtags
  end
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  get 'messages', to: 'messages#index'
  post 'messages', to: 'messages#create'

  get 'logout', to: 'sessions#end'

  root 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
