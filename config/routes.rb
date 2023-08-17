Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :trips
  resources :users, only: %i[index create]
  root 'users#index'
end
