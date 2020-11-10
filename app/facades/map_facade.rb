class MapFacade
  include KeyVerification

  def self.location_details(location)
    response = MapService.location_details(location)
    create_location(JSON.parse(response.body, symbolize_names: true))
  end

  def self.road_trip(road_trip_params)
    if KeyVerification.valid_key?(road_trip_params[:api_key])
      route = route_details(road_trip_params[:origin], road_trip_params[:destination])
      if route[:route][:formattedTime]
        forecast = ForecastFacade.forecast_details_50_hours(road_trip_params[:destination])
        create_road_trip(road_trip_params, route, forecast)
      else
        return Error.new("Impossible Route!")
      end
    else
      Error.new("That key is not valid!")
    end
  end

  def self.route_details(origin, destination)
    response = MapService.route_details(origin, destination)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.create_location(location)
    Location.new(location)
  end

  def self.create_road_trip(road_trip_params, route, forecast)
    RoadTrip.new(road_trip_params, route, forecast)
  end
end
