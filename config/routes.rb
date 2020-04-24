Rails.application.routes.draw do
  resources :favorites, only: [:create, :destroy]
  get '/users/:id/favorites', to: 'users#favorites'
  resources :feeds
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :pictures do
    collection do
      post :confirm
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
