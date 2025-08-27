Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :habits, only: [:index, :show, :new, :create]
  resources :trackers, only: [:new, :create]

  # resources :habits do
  #   resources :goals
  #   resources :tips
  # end

  # resources :habit_types
  # resources :programs
  # resources :groups do
  #   resources :group_members
  # end
  # resources :app_achievements
  # resources :user_achievements

end
