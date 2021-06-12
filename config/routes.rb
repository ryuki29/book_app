Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'reviews#index'

  resources :users, only: %i[index show update] do
    member do
      get :following, :followers
    end
    get :likes, on: :collection
  end

  resources :books do
    collection do
      get 'search'
    end
  end

  namespace :reviews do
    resources :searches, only: :index
    resources :action_plans, only: %i[show update]
  end

  resources :reviews, only: %i[create destroy show] do
    resources :comments, only: %i[create destroy]
    resource :likes, only: %i[create destroy]
  end

  namespace :boards do
    resources :searches, only: :index
  end

  resources :boards, only: %i[index show create update destroy] do
    resources :board_comments, only: %i[create destroy]
  end

  resources :relationships, only: %i[create destroy]
  resources :messages, only: %i[create destroy]
  resources :rooms, only: %i[index create show]
  resources :notifications, only: %i[index destroy]
end
