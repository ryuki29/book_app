Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'reviews#index'

  resources :users, only: %i[show update] do
    get :likes, on: :collection
  end

  resources :books do
    collection do
      get 'search'
    end
  end

  resources :reviews, only: %i[create destroy show] do
    resources :comments, only: %i[create destroy]
    resource :likes, only: %i[create destroy]
  end

end
