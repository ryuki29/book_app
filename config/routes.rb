Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks"}
  root 'reviews#index'

  resources :users, only: :show

  resources :books do
    collection do
      get 'search'
    end
  end

  resources :reviews, only: [:create, :destroy, :show]

end
