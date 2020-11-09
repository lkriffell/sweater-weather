require 'rails_helper'

RSpec.describe 'forecast facade' do
  describe 'forecast_details' do
    describe 'returns a forecast object for' do
      it 'current_weather' do
        VCR.use_cassette 'denver_co' do
          params = {location: 'denver,co'}
          location = MapFacade.location_details(params[:location])
          response_keys = {current: Hash, hourly: Array, daily: Array}

          VCR.use_cassette 'denver_co_current_forecast' do
            forecast = ForecastFacade.forecast_details(location)
            current_forecast_keys = {dt: Date,
                                    sunrise: Date,
                                    sunset: Date,
                                    temp: Integer,
                                    feels_like: Float,
                                    humidity: Integer,
                                    uvi: Float,
                                    visibility: Integer,
                                    conditions: String,
                                    icon: String
                                  }

            expect(forecast.current_weather[:dt].class).to eq(current_forecast_keys[:dt])
            expect(forecast.current_weather[:sunrise].class).to eq(current_forecast_keys[:sunrise])
            expect(forecast.current_weather[:sunset].class).to eq(current_forecast_keys[:sunset])
            expect(forecast.current_weather[:temp].to_s.numeric?).to eq(true)
            expect(forecast.current_weather[:feels_like].class).to eq(current_forecast_keys[:feels_like])
            expect(forecast.current_weather[:humidity].class).to eq(current_forecast_keys[:humidity])
            expect(forecast.current_weather[:uvi].class).to eq(current_forecast_keys[:uvi])
            expect(forecast.current_weather[:visibility].class).to eq(current_forecast_keys[:visibility])
            expect(forecast.current_weather[:conditions].class).to eq(current_forecast_keys[:conditions])
            expect(forecast.current_weather[:icon].class).to eq(current_forecast_keys[:icon])
          end
        end
      end
      xit 'daily_weather' do
        VCR.use_cassette 'denver_co' do
          params = {location: 'denver,co'}
          location = MapFacade.location_details(params[:location])
          response_keys = {current: Hash, hourly: Array, daily: Array}

          VCR.use_cassette 'denver_co_daily_forecast' do
            forecast = ForecastFacade.forecast_details(location)
            daily_forecast_keys = {dt: Date,
                                    sunrise: Date,
                                    sunset: Date,
                                    max_temp: Float,
                                    min_temp: Float,
                                    conditions: String,
                                    icon: String
                                  }

            forecast.daily_weather.each do |day|
              expect(day[:dt].class).to eq(daily_forecast_keys[:dt])
              expect(day[:sunrise].class).to eq(daily_forecast_keys[:sunrise])
              expect(day[:sunset].class).to eq(daily_forecast_keys[:sunset])
              expect(day[:max_temp].class).to eq(daily_forecast_keys[:max_temp])
              expect(day[:min_temp].class).to eq(daily_forecast_keys[:min_temp])
              expect(day[:conditions].class).to eq(daily_forecast_keys[:conditions])
              expect(day[:icon].class).to eq(daily_forecast_keys[:icon])
            end
          end
        end
      end
      it 'hourly_weather' do
        VCR.use_cassette 'denver_co' do
          params = {location: 'denver,co'}
          location = MapFacade.location_details(params[:location])
          response_keys = {current: Hash, hourly: Array, daily: Array}

          VCR.use_cassette 'denver_co_hourly_forecast' do
            forecast = ForecastFacade.forecast_details(location)
            hourly_forecast_keys = {dt: Date,
                                    wind_speed: Float,
                                    wind_direction: String,
                                    conditions: String,
                                    icon: String
                                  }

            forecast.hourly_weather.each do |hour|
              expect(hour[:dt].class).to eq(hourly_forecast_keys[:dt])
              expect(hour[:wind_speed].class).to eq(hourly_forecast_keys[:wind_speed])
              expect(hour[:wind_direction].class).to eq(hourly_forecast_keys[:wind_direction])
              expect(hour[:conditions].class).to eq(hourly_forecast_keys[:conditions])
              expect(hour[:icon].class).to eq(hourly_forecast_keys[:icon])
            end
          end
        end
      end
    end
  end
end
class String
  def numeric?
      Float(self) != nil rescue false
  end
end
