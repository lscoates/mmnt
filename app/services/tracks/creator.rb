class Tracks::Creator < ServicesBase
  attr_reader :user, :params

  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    if new_track.save
      Result.new(success?: true, data: new_track, errors: [])
    else
      Result.new(success?: false, data: new_track, errors: new_track.errors)
    end
  end

  private

  def new_track
    @new_track ||= user.tracks.new(params)
  end
end
