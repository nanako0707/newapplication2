Rails.application.routes.draw do
  resources :favorites, only: [:create, :destroy]
  resources :feeds
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :pictures do
    collection do
      post :confirm
    end
  end
end
