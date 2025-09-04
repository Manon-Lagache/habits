Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :pages, only: :home
  resources :habits, only: [:index, :show, :new, :create, :destroy]
  resources :trackers
  resources :challenges, only: [:index, :show] do
    member do
      post :join
    end
  end

  get "calendar", to: "calendar#index", as: :calendar_index

  resources :calendar, only: [] do
    collection do
      get :day
    end
  end

  # Routes pour les erreurs
  # Utilisation de match pour get, post, patch, delete
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

end
