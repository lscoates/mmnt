class Tracks::Finder
  def self.tracks_for_user(user)
    user.tracks
  end

  def self.track_for_user(user, id)
    user.tracks.includes(:moments).find_by(id: id)
  end
end
