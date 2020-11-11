require 'rails_helper'

RSpec.describe 'forecast facade' do
  describe 'forecast_details' do
    describe 'returns a forecast object for' do
      it 'current_weather' do
        VCR.use_cassette 'denver_co_forecast_current' do
          params = {location: 'denver,co'}
          response_keys = {current: Hash, hourly: Array, daily: Array}
          forecast = ForecastFacade.forecast_details(params[:location])
          numeric = [Integer, Float]
          current_forecast_keys = {
                                  dt: Date,
                                  sunrise: Date,
                                  sunset: Date,
                                  temp: String,
                                  feels_like: String,
                                  humidity: [Integer, Float],
                                  uvi: [Integer, Float],
                                  visibility: [Integer, Float],
                                  conditions: String,
                                  icon: String
                                }

          forecast.current_weather.each do |key, value|
            if numeric.include?(forecast.current_weather[key].class)
              expect(current_forecast_keys[key]).to include(forecast.current_weather[key].class)
            else
              expect(forecast.current_weather[key]).to be_a(current_forecast_keys[key])
            end
          end
        end
      end
      it 'daily_weather' do
        VCR.use_cassette 'denver_co_daily_forecast' do
          params = {location: 'denver,co'}
          response_keys = {current: Hash, hourly: Array, daily: Array}
          forecast = ForecastFacade.forecast_details(params[:location])
          daily_forecast_keys = {dt: Date,
                                  sunrise: Date,
                                  sunset: Date,
                                  max_temp: String,
                                  min_temp: String,
                                  conditions: String,
                                  icon: String
                                }

          forecast.daily_weather.each do |day|
            day.each do |key, value|
              expect(day[key]).to be_a(daily_forecast_keys[key])
            end
          end
        end
      end
      it 'hourly_weather' do
        VCR.use_cassette 'denver_co_hourly_forecast' do
          params = {location: 'denver,co'}
          response_keys = {current: Hash, hourly: Array, daily: Array}
          forecast = ForecastFacade.forecast_details(params[:location])
          hourly_forecast_keys = {dt: Date,
                                  wind_speed: String,
                                  wind_direction: String,
                                  conditions: String,
                                  icon: String,
                                  temperature: String
                                }

          forecast.hourly_weather.each do |hour|
            hour.each do |key, value|
              expect(hour[key]).to be_a(hourly_forecast_keys[key])
            end
          end
        end
      end
    end
  end
end
