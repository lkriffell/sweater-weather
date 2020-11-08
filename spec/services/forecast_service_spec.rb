require 'rails_helper'

RSpec.describe 'forecast facade' do
  describe 'forecast_details' do
    describe 'returns a forecast object for' do
      it 'current_weather' do
        VCR.use_cassette 'denver_co' do
          params = {location: 'denver,co'}
          location = MapFacade.location_details(params[:location])

          VCR.use_cassette 'denver_co_current_forecast' do
            forecast = ForecastService.forecast_details(location)
            forecast = JSON.parse(forecast.body, symbolize_names: true)
            response_keys = {current: Hash, hourly: Array, daily: Array}
            forecast_keys = {dt: Date,
                                    sunrise: Date,
                                    sunset: Date,
                                    temp: Float,
                                    feels_like: Float,
                                    humidity: Integer,
                                    uvi: Float,
                                    visibility: Integer,
                                    description: String,
                                    icon: String
                                  }

            expect(forecast.keys).to include(response_keys.keys)

          end
        end
      end
    end
  end
end
