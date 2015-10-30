Rails.application.routes.draw do
  resources :users
  resources :products, only: [:new, :create, :edit, :update, :show]
  resources :bids, only: [:new, :create]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/home' => 'users#home'
  get '/pending_products' => 'products#pending'

  root 'sessions#new'
end
