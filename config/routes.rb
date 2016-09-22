Rails.application.routes.draw do
  get '/auth/spotify/callback', to: 'users#spotify'
  root 'users#new'
  get '/welcome' => 'users#home'
  
  resources :events
end
