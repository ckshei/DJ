class EventsController < ApplicationController
  def new
  end

  def create
    @event = Event.create(event_params)
    @event.guests << current_user
    @event.create_playlist
    @event.save
    redirect_to event_path(@event) 
  end

  def edit
  end

  def update
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
  end

  def guest
    event = Event.find(params[:id])
    current_user
    if event.guests.include?(@current_user)
      redirect_to event_path(event)
    else
      event.guests << @current_user
      event.save
      event.add_songs(@current_user)
      redirect_to event_path(event)
    end    
  end

  def refresh_playlist
    event = Event.find(params[:id])
    playlist = event.playlist
    add_array = playlist.add_songs
    spotify_playlist = RSpotify::Playlist.find(playlist.host_id.to_s, playlist.playlist_id)
    add_tracks = []
    add_array.each do |id|
      add_tracks << RSpotify::Track.find(id)
    end
    playlist.add_songs.clear
    playlist.save
    spotify_playlist.add_tracks!(add_tracks)
    redirect_to event_path(event)
  end
  private

  def event_params
    params.require(:event).permit(:name, :date, :host_id)
  end
end
