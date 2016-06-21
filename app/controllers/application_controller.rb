class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def default
    render json: {success: 200, response: "Are you looking for /api/birds?"}
  end
end
