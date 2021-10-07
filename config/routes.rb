Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show]
  root to: 'quests#index'
  resources :quests, only: [:new, :create,]
end
