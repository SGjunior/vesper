Rails.application.routes.draw do
  devise_for :users
  root to: 'venues#index'

  resources :venues, { only: [:index, :show] }
  resources :squad, { only: [:new, :show] }

  # get '/dashboard', to: 'user#index', as: 'user_dashboard' # if we have time
end
