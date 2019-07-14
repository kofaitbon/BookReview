Rails.application.routes.draw do
  get 'sample/index'
  devise_for :users
  resources :books
  root 'books#index'
end
