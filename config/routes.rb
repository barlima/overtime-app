Rails.application.routes.draw do

  root to: 'static#homepage'

  devise_for :users, skip: [:registrations]

  resources :posts do
    member do
      get :approve
    end
  end

  resources :audit_logs, except: %i(new edit destroy) do
    member do
      get :confirm
    end
  end

  namespace :admin do
    resources :users
    resources :posts
    resources :admin_users

    root to: 'users#index'
  end
end
