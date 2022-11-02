Rails.application.routes.draw do
  
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :maps
  resources :spots
  
end
