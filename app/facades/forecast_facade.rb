class ForecastFacade
  def self.forecast_details(location_param)
    location = MapFacade.location_details(location_param)
    response = ForecastService.forecast_details(location)
    create_forecast(JSON.parse(response.body, symbolize_names: true))
  end

  def self.forecast_details_50_hours(location_param)
    location = MapFacade.location_details(location_param)
    response = ForecastService.forecast_details(location)
    create_forecast_custom_hours(JSON.parse(response.body, symbolize_names: true), 50)
  end

  def self.create_forecast_custom_hours(forecast, hours)
    Forecast.new(forecast, hours)
  end

  def self.create_forecast(forecast)
    Forecast.new(forecast)
  end
end
