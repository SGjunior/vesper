Rails.application.routes.draw do
  get 'squadmember/create'
  devise_for :users
  root to: 'venue#index'

  resources :venue, { only: [:index, :show] }
  resources :squad, { only: [:edit, :show, :update, :create] } do
    resource :squadmember, { only: [:create] }
  end

  post '/squad/:id/package/:package_id', to: 'squad#update_package', as: 'squad_package'
  post '/squad/:id/confirm', to: 'squad#confirm_squad_order', as: 'squad_confirm'
  post '/squad/:id/edit/:venue_id', to: 'squad#confirm_squad_member', as: 'member_confirm'
  # get '/dashboard', to: 'user#index', as: 'user_dashboard' # if we have time
end
