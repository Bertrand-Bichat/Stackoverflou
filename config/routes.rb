Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :topics
  resources :messages, only: [:new, :create, :edit, :update, :destroy]
  root to: 'topics#index'
end
