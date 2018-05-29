Rails.application.routes.draw do
  devise_for :users
  root to: 'venue#index'

  resources :venue, { only: [:index, :show] }
  resources :squad, { only: [:edit, :show, :update, :create] } do
    resource :squadmember, { only: [:create] }
  end

  # get '/dashboard', to: 'user#index', as: 'user_dashboard' # if we have time
end
