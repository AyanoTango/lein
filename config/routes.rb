Rails.application.routes.draw do
  resources :relationships
  get 'sessions/new'

  root             'sessions#index'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  post   'relationships' => 'relationships#create'

  resources :rooms
  resources :comments
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
