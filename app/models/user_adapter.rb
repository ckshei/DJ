class UserAdapter

  def self.create(spotify_user)
    hash = spotify_user.to_hash
    user = User.find_or_create_by(:uid => hash["id"])
    user.update(
      :display_name => hash["display_name"], 
      :email => hash["email"],
      :top_tracks => spotify_user.top_tracks.map(&:id).take(5).to_s,
      :top_artists => spotify_user.top_artists.map(&:id).take(5).to_s
    )
    user
  end

end
