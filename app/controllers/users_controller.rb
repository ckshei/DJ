class UsersController < ApplicationController
  def new

  end
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    user = UserAdapter.create(spotify_user)
    if user
      session[:user_id] = user.id
      redirect_to welcome_path
    else
      flash[:error] = 'You fucked up'
    end

  end
  def home
    current_user
    @event = Event.new
  end
end
