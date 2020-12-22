class Tracks::Creator < ServicesBase
  attr_reader :user, :params

  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    if new_track.save
      success(new_track)
    else
      error(new_track.errors)
    end
  end

  private

  def new_track
    @new_track ||= user.tracks.new(params)
  end
end
