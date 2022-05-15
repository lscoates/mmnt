class Moments::Updater < ServicesBase
  attr_reader :moment, :params

  def initialize(moment:, params:)
    @moment = moment
    @params = params
  end

  def call
    Moment.transaction do
      return Result.new(success?: true, data: moment, errors: []) if params.nil?

      optimize_feature_image

      if moment.update(params)
        Result.new(success?: true, data: moment, errors: [])
      else
        Result.new(success?: false, data: moment, errors: moment.errors)
      end
    end
  end

  private

  def optimize_feature_image
    return if params[:feature_image].blank?

    UploadedImageOptimizer.call(params[:feature_image].tempfile.path)
  end
end
