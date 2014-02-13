Fmm2::Application.routes.draw do
  resources :sessions,  only: [:new, :create, :destroy]
  resources :users, only: [:show, :edit, :update]

  namespace :admin do
    resources :users, only: [:new, :create, :index, :destroy]
    resources :positions
  end
  
  root  'static_pages#home'

  match '/signin',  to: 'sessions#new',               via: 'get'
  match '/signout', to: 'sessions#destroy',           via: 'delete'
end
