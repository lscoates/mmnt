class MomentsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    result = Moments::Creator.new(track: track, params: moment_params).call

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

  def track
    track = current_user.tracks.find_by(id: params[:track_id])

    if track.present?
      track
    else
      render json: { errors: "Could not find the specific track" }, status: :not_found
    end
  end

  def moment_params
    params.require(:moment).permit(
      :body,
    )
  end
end
