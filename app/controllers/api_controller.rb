class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found

  def not_found
    # raise ActionController::RoutingError.new('Not Found')
    render json: {status: 404}, status: 404
  end
end
