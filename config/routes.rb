Fmm2::Application.routes.draw do
  root  'static_pages#home'

  namespace :admin do
    resources :positions
  end
end
