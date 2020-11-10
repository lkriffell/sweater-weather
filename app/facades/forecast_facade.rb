class ForecastFacade
  def self.forecast_details(location_param)
    location = MapFacade.location_details(location_param)
    response = ForecastService.forecast_details(location)
    create_forecast(JSON.parse(response.body, symbolize_names: true))
  end

  def self.create_forecast(forecast)
    Forecast.new(forecast)
  end
end
