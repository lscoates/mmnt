class TracksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tracks = current_user.tracks
  end
end
