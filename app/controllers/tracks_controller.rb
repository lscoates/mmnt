class TracksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tracks = current_user.tracks
  end

  def new; end

  def create
    result = ::Tracks::Creator.new(user: current_user, params: track_params).call

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

  def track_params
    params.require(:track).permit(
      :name,
    )
  end
end
