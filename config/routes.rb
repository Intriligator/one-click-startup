Rails.application.routes.draw do
  resources :users

  resources :products, only: [:new, :create, :edit, :update, :show, :destroy] do
    member do
      get 'pay'
    end
  end

  resources :bids, only: [:new, :create]
  resources :conversations, only: [:show]
  resources :messages, only: [:new, :create]
  resources :charges

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/home' => 'users#home'
  get '/pending_products' => 'products#pending'
  get '/pending_user_products' => 'users#pending'
  get '/inbox' => 'users#inbox'
  get '/notifications' => 'users#notifications'
  get '/won_products' => 'users#won_products'

  root 'sessions#new'
end
