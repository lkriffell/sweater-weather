class Api::V1::ForecastController < ApplicationController
  def index
    location = MapFacade.location_details(params['location'])
    forecast = ForecastFacade.forecast_details(location)
    render json: forecast_serializer(forecast)
  end

  private

  def forecast_serializer(forecast)
    {
      "data": {
        "weather": {
          "current": forecast.current_weather,
          "daily": forecast.daily_weather,
          "hourly": forecast.hourly_weather
        }
      }
    }
  end
end
