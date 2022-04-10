class Moments::Creator < ServicesBase
  attr_reader :track, :params

  def initialize(track:, params:)
    @track = track
    @params = sanitized_params(params)
  end

  def call
    optimize_feature_image

    if new_moment.save
      Result.new(success?: true, data: new_moment, errors: [])
    else
      Result.new(success?: false, data: new_moment, errors: new_moment.errors)
    end
  end

  private

  def optimize_feature_image
    return if params[:feature_image].blank?

    UploadedImageOptimizer.call(params[:feature_image].tempfile.path)
  end

  def sanitized_params(params)
    params = params.presence || {}

    if params[:feature_image].blank?
      params.except(:feature_image)
    else
      params
    end
  end

  def new_moment
    @new_moment ||= track.moments.new(params)
  end
end
