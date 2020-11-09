class Trail
  attr_reader :name,
              :summary,
              :difficulty,
              :location,
              :current_conditions,
              :distance_to_trail

  def initialize(trail_params, start_location)
    @name = trail_params[:name]
    @summary = trail_params[:summary]
    @difficulty = trail_params[:difficulty]
    @location = trail_params[:location]
    @forecast = forecast(trail_params)
    @current_conditions = [@forecast.current_weather[:temp], @forecast.current_weather[:conditions]]
    @distance_to_trail = distance(start_location)
  end

  def forecast(trail_params)
    ForecastFacade.forecast_details(location_object(trail_params))
  end

  def distance(start_location)
    MapFacade.route_details(start_location, @location)
  end

  def location_object(trail_params)
    location_params = { results:
                        [  locations: [
                          latLng: { lat: trail_params[:latitude], lng: trail_params[:longitude] }  ]  ]
                      }
    location = Location.new(location_params)
  end
end
