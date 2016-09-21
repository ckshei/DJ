Rails.application.routes.draw do
  get '/auth/spotify/callback', to: 'users#spotify'
  root 'users#new'
  get '/welcome' => 'users#home'
end
