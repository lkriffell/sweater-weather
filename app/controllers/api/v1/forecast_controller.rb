class Api::V1::ForecastController < ApplicationController
  def index
    location = MapFacade.location_details(params['location'])
    forecast = ForecastFacade.forecast_details(location)
    render json: ForecastSerializer.new(forecast)
  end
end
