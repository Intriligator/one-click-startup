Rails.application.routes.draw do
  resources :users

  resources :products, only: [:new, :create, :edit, :update, :show, :destroy] do
    member do
      get 'pay'
      post 'charge'
      get 'confirm'
    end
  end

  resources :bids, only: [:new, :create]
  resources :conversations, only: [:show]
  resources :messages, only: [:new, :create]
  resources :likes, only: [:create]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/home' => 'users#home'
  get '/pending_products' => 'products#pending'
  get '/pending_user_products' => 'users#pending'
  get '/inbox' => 'users#inbox'
  get '/notifications' => 'users#notifications'
  get '/won_products' => 'users#won_products'
  get '/terms' => 'application#terms'

  root 'sessions#new'
end
