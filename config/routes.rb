Rails.application.routes.draw do
  root 'users#index'

  resources :users, except: [:destroy]
  resources :sessions, only: [:new, :create, :destroy]
  # resources :sessions
  resources :questions, except: [:show, :new, :index]

  get 'users' => 'users#show'

  get 'sign_up' => 'users#new'
  get 'log_in' => 'sessions#new'
  get 'log_out' => 'sessions#destroy'

  # get 'show' => 'users#show'
end
