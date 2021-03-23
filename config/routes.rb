Rails.application.routes.draw do
  constraints ->(request) { request.session[:user_id].present? } do
    root 'posts#index'
  end

  root 'user_sessions#new'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :posts
end
