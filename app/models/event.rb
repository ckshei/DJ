class Event < ActiveRecord::Base
  belongs_to :host, :class_name => "User"
  has_one :playlist
  has_many :event_guests
  has_many :guests, through: :event_guests, :class_name => "User"
  scope :expired, -> { where('date < ?', Date.today) }

  def create_playlist
    hash = self.host.spotify_hash
    user = RSpotify::User.new(hash)
    spotify_playlist = user.create_playlist!("#{self.name}-playlist") 
    spotify_playlist.add_tracks!(user.top_tracks(limit: 5)) 
    playlist = Playlist.new
    playlist.update(
      event_id: self.id,
      host_id: user.id, 
      playlist_id: spotify_playlist.id,
      current_songs: spotify_playlist.tracks.map(&:id).to_set,
      url: spotify_playlist.external_urls["spotify"]
    )
    playlist.save
  end

  def add_songs(user)
    user.top_tracks.each do |id|
      if playlist.current_songs.include?(id)
        next
      else
        playlist.add_songs << id
      end
      playlist.save
    end
  end
end
