# frozen_string_literal: true

Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  resources :posts, only: %i[index show] do
    resources :comments, only: %i[create]
  end

  namespace :admin do
    root to: "posts#index"
    resources :posts
    resources :categories
    resources :tags
    resources :comments, only: %i[index destroy]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "posts#index"
end
