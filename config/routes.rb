Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :habits, only: [:index, :show, :new, :create]
end
