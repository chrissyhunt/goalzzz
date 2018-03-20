Rails.application.routes.draw do
  resources :users
  resources :goals do
    resources :results, only: [:new, :create, :show, :edit, :update, :destroy]
  end
  resources :reflections
  resources :sessions, only: [:create, :destroy]

  get '/auth/facebook/callback' => 'sessions#create'

  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
