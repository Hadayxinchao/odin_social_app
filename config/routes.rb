Rails.application.routes.draw do
  root 'posts#index'
  resources :users
  resources :posts
  resources :friends, except: %i[show new edit], controller: 'friendships'
  devise_for :users, path: 'accounts'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
