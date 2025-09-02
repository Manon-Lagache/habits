require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :pages, only: :home
  resources :habits, only: [:index, :show, :new, :create]
  resources :trackers
  resources :challenges, only: [:index, :show]
  resources :calendar, only: [:index]

  mount Sidekiq::Web => "/sidekiq"

end
