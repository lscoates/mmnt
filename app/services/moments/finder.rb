class Moments::Finder
  def self.moments_for_track(track)
    track.moments.order(created_at: :asc)
  end
end
