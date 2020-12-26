class Moments::Creator < ServicesBase
  attr_reader :track, :params

  def initialize(track:, params:)
    @track = track
    @params = params
  end

  def call
    if new_moment.save
      success(new_moment)
    else
      error(new_moment.errors)
    end
  end

  private

  def new_moment
    @new_moment ||= track.moments.new(params)
  end
end
