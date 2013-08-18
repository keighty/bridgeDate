Bridge::Application.routes.draw do
  resources :clubs

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'pages#home'
  match '/help', to: 'pages#help', via: 'get'
  match '/about', to: 'pages#about', via: 'get'

  match '/signup', to: 'users#new', via: 'get'

  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

end
