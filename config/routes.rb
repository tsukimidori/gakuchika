Rails.application.routes.draw do
  devise_for :users
  root to: 'quests#index'

  resources :users, only: [:show]
end
