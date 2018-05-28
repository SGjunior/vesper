Rails.application.routes.draw do
  get 'squad/new'
  get 'squad/show'
  get 'venue/index'
  get 'venue/show'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
