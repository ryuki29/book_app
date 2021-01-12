Rails.application.routes.draw do
  root 'books#index'

  resources :books do
    collection do
      get 'search'
    end
  end

  devise_for :users
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
