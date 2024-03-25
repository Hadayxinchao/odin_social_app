Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, except: %i[edit update]
  resources :users, only: [:index, :show] do
    resources :friends, only: %i[index], controller: 'friendships'
  end
  resources :friends, only: %i[create update destroy], controller: 'friendships', as: 'friendships'
  resources :notifications, only: %i[destroy]
  resources :likes, only: %i[create destroy]
  resources :comments, only: %i[create destroy]
  devise_for :users, path: 'accounts', controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                                      registrations: 'users/registrations',
                                                      sessions: 'users/sessions' }
  devise_scope :user do
    get '/accounts/complete', to: 'users/registrations#complete_edit'
    put '/accounts/complete', to: 'users/registrations#complete_update'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
