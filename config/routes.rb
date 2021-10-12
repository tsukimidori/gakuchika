Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show]
  root to: 'quests#index'
  resources :quests do
    resources :applies, only: [:index, :create, :destroy]
    resources :joins, only: [:index, :create, :destroy]
    resources :messages, only: [:create]
  end
end
