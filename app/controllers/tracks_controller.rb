class TracksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_track, only: [:show]

  def index
    @tracks = Tracks::Finder.tracks_for_user(current_user)
  end

  def show
    @moments = Moments::Finder.moments_for_track(@track)
  end

  def new; end

  def create
    result = Tracks::Creator.new(user: current_user, params: track_params).call

    respond_to do |format|
      if result.success?
        flash[:success] = "New track successfully created!"

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
    @track = Tracks::Finder.track_for_user(current_user, params[:id])

    unless @track.present?
      render json: { errors: "Could not find the specified track" }, status: :not_found
    end
  end

  def track_params
    params.require(:track).permit(
      :name,
    )
  end
end
