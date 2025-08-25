Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"


  resources :habits do
    resources :goals
    resources :trackers
    resources :tips
  end

  resources :habit_types
end
