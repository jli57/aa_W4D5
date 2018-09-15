Rails.application.routes.draw do
  resources :comments, only: [:create]
  resources :goals, except: [:index]
  resources :users, only: [:index, :show, :new, :create]
  resource :session, only: [:new, :create, :destroy]
end
