Rails.application.routes.draw do
  get 'squadmember/create'
  devise_for :users
  root to: 'venue#index'

  resources :venue, { only: [:index, :show] }
  resources :squad, { only: [:new, :show, :update] } do
    resources :squadmember, { only: [:create] }
  end
  # get '/dashboard', to: 'user#index', as: 'user_dashboard' # if we have time
end
