class UsersController < ApplicationController
  def new
    @user = User.new
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
  def create
    user = User.create(user_params)
    session[:user_id] = user.id
    redirect_to welcome_path
  end
  
  def user_params
    params.require(:user).permit(:uid, :display_name, :password, :email, :top_tracks, :top_artists)
  end
end
