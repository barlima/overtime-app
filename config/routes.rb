Rails.application.routes.draw do
  root to: 'static#homepage'

  devise_for :users, skip: [:registrations]

  resources :posts

  namespace :admin do
    resources :users
    resources :posts
    resources :admin_users

    root to: 'users#index'
  end
end
