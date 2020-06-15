Rails.application.routes.draw do

  get "your" => 'user_blogs#your'
  resources :posts do
    resources :comments
  end

  resources :comments

  resources :user_blogs do
    resources :posts do
      resources :comments
    end
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root 'posts#index'

  get 'home/authors'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
