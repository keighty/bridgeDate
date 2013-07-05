Bridge::Application.routes.draw do
  resources :users

  root to: 'pages#home'
  match '/help', to: 'pages#help', via: 'get'
  match '/about', to: 'pages#about', via: 'get'

  match '/signup', to: 'users#new', via: 'get'
end
