Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/show'
  get 'reviews/edit'
  get 'reviews/update'
  get 'reviews/destroy'
  devise_for :users
  root 'books#index'
  get 'books/show'
  get 'books/search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
