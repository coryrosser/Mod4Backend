Rails.application.routes.draw do
  resources :user_friends
  resources :comments
  resources :pictures
  resources :projects
  resources :users

  post '/login', to: 'sessions#create'
  post '/signup', to: 'users#create'
  patch '/friend', to: 'user_friends#update'
  delete '/deleteRequest', to: 'user_friends#destroy'
  patch '/generateToken', to: 'users#token'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
