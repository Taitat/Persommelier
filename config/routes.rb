Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  
  get 'questions/search'
  get 'posts/create_complete'
  
  post 'users/enchant'
  root to: "posts#index"
  post '/posts/guest_sign_in', to: 'posts#new_guest'
  

  resources :users, only: [:show] do
    member do
      get 'favorites'
    end
    resources :answers, only: [:index,:show,:create]
  end

  resources :questions, only: [:index,:new,:create,:show]
  resources :characteristics, only: [:index,:create]
  resources :posts, only: [:index, :create, :show, :destroy] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  

  
end
