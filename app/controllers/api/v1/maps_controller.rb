class Api::V1::MapsController < ApplicationController
  def create
    road_trip = MapFacade.road_trip(road_trip_params)
    if road_trip.class == RoadTrip
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: ErrorSerializer.new(road_trip)
    end
  end

  private

  def road_trip_params
    JSON.parse(request.raw_post, symbolize_names: true)
  end
end
