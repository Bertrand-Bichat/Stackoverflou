Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :topics
  resources :messages, only: [:create, :edit, :update, :destroy]
  root to: 'topics#index'
end
