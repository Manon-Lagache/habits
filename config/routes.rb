Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :habits do
    resources :goals
    resources :trackers
    resources :tips
  end

  resources :habit_types
  resources :programs
  resources :groups do
    resources :group_members
  end
  resources :app_achievements
  resources :user_achievements

  root "habits#index"
end
