Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, except: [:destroy]
  resources :session, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]

  get 'sign_up' => 'user#new'
  get 'log_in' => 'sessions#new'
  get 'log_out' => 'sessions#destroy'


  # get 'show' => 'users#show'
end
