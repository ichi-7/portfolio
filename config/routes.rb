Rails.application.routes.draw do
  
  devise_for :users
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :users
  resources :maps
  resources :spots
  resources :posts
  get '/plans/route' => 'plans#route'
  get '/plans/info' => 'plans#info'
  get '/plans/confirm' => 'plans#confirm'
  resources :plans
  resources :places
  
end
