class UsersController < ApplicationController
  def new

  end
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    byebug    
    if spotify_user
      redirect_to welcome_path
    else
      flash[:error] = 'You fucked up'
    end

  end
  def home
    byebug    
  end
end
