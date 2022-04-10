class TracksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_track, only: [:show]

  def index
    @tracks = Tracks::Finder.tracks_for_user(current_user)
  end

  def show
    @moments = Moments::Finder.moments_for_track(@track)
  end

  def new
    @track = Track.new
    @errors = []
  end

  def create
    result = Tracks::Creator.new(user: current_user, params: track_params).call

    if result.success?
      flash[:success] = "New track successfully created!"
      redirect_to tracks_path
    else
      @track = result.data
      @errors = result.errors
      render :new, status: :unprocessable_entity
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
