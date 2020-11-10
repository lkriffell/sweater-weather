class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.forecast_details(params['location'])
    render json: ForecastSerializer.new(forecast)
  end
end
