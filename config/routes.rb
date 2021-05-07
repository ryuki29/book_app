Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'reviews#index'

  resources :users, only: [:show, :update] do
    get :likes, on: :collection
  end

  resources :books do
    collection do
      get 'search'
    end
  end

  resources :reviews, only: [:create, :destroy, :show] do
    resource :likes, only: [:create, :destroy]
  end

end
