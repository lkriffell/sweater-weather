class Api::V1::TrailsController < ApplicationController
  def index
    location = MapFacade.location_details(params['location'])
    render json: TrailSerializer.new(TrailsFacade.trail_details(location, params['location']))
  end
end
