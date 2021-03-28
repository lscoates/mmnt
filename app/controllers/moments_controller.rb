class MomentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_track, only: [:new, :create]

  def new; end

  def create
    result = Moments::Creator.new(track: @track, params: moment_params).call

    respond_to do |format|
      if result.success?
        flash[:success] = "New moment successfully created!"

        format.json do
          render json: result.data, status: :created
        end
      else
        format.json do
          render json: { errors: result.data }, status: :unprocessable_entity
        end
      end
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
      :body,
      :original_date,
      :title,
      :feature_image,
    )
  end
end
