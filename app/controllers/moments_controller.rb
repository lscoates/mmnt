class MomentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_track, only: [:new, :create]

  def new
    @moment = Moment.new
    @errors = []
  end

  def create
    result = Moments::Creator.new(track: @track, params: moment_params).call

    if result.success?
      flash[:success] = "New moment successfully created!"
      redirect_to track_path(@track)
    else
      @moment = result.data
      @errors = result.errors
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_track
    @track = Tracks::Finder.track_for_user(current_user, params[:track_id])

    unless @track.present?
      render json: { errors: "Could not find the specified track" }, status: :not_found
    end
  end

  def moment_params
    params.require(:moment).permit(
      :content,
      :original_date,
      :title,
      :feature_image,
    )
  end
end
