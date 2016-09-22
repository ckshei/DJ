class Event < ActiveRecord::Base
  belongs_to :host, :class_name => "User"
  has_many :event_guests
  has_many :guests, through: :event_guests, :class_name => "User"

  def create_playlist
    hash = self.host.spotify_hash
    user = RSpotify::User.new(hash)
    playlist = user.create_playlist!("#{self.name}-playlist")
    playlist.add_tracks!(user.top_tracks(limit: 5))
    self.playlist = playlist.external_urls["spotify"]
  end

end
