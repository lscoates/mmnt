class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    tracks_path
  end

  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end
end
