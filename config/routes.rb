Rails.application.routes.draw do
  resources :reflections
  resources :results
  resources :goals
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
