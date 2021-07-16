Rails.application.routes.draw do

  root 'posts#index'

  get "friends", to: "users#friends"
  get "requests_not_confirmed", to: "users#requests_not_confirmed"

  devise_for :users
  resources :friendships

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
