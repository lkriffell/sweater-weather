class Api::V1::MapsController < ApplicationController
  def create
    road_trip = MapFacade.road_trip(road_trip_params)
  end

  private

  def road_trip_params
    JSON.parse(request.raw_post, symbolize_names: true)
  end
end
