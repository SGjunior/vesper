Rails.application.routes.draw do
  get 'squadmember/create'
  devise_for :users
  root to: 'venue#welcome'

  resources :venue, { except: [:destroy] }
  resources :squad, { only: [:edit, :show, :update, :create] } do
    resource :squadmember, { only: [:create] }
  end

  post '/squad/:id/package/:package_id', to: 'squad#update_package', as: 'squad_package'
  post '/squad/:id/confirm', to: 'squad#confirm_squad_order', as: 'squad_confirm'
  post '/squad/:id/member/confirm', to: 'squad#confirm_squad_member', as: 'member_confirm'
  # get '/dashboard', to: 'user#index', as: 'user_dashboard' # if we have time
  get 'squad/:id/sidekicks', to: 'squad#add_sidekick', as: 'add_sidekick'
  post 'squad/:id/squadmembers/:adding_user_id', to: 'squad#update', as: 'create_squadmember'

end
