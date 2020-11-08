require 'rails_helper'

RSpec.describe 'forecast service' do
  describe 'forecast_details' do
    describe 'returns a forecast json for' do
      VCR.use_cassette 'denver_co' do
        params = {location: 'denver,co'}
        location = MapFacade.location_details(params[:location])

        VCR.use_cassette 'denver_co_current_forecast' do
          forecast = ForecastService.forecast_details(location)
          forecast = JSON.parse(forecast.body, symbolize_names: true)

          it 'doesnt include :minutely' do
            response_keys = {current: Hash, hourly: Array, daily: Array}
            response_keys.keys.each { |key|  expect(forecast.keys).to include(key) }
            expect(forecast.keys).to_not include(:minutely)
          end

          it 'current_weather' do
            current = {
                       dt:Integer,
                       sunrise:Integer,
                       sunset:Integer,
                       temp:Integer,
                       feels_like:Float,
                       pressure:Integer,
                       humidity:Integer,
                       dew_point:Float,
                       uvi:Float,
                       clouds:Integer,
                       visibility:Integer,
                       wind_speed:Float,
                       wind_deg:Integer,
                       wind_gust:Float,
                       weather: Array,
                      }
             weather = {
                        id:Integer,
                        main:String,
                        description:String,
                        icon:String
                       }

             expect(forecast[:current].keys).to eq(current.keys)
             expect(forecast[:current][:weather][0].keys).to eq(weather.keys)
             expect(forecast[:current][:weather][0].keys).to eq(weather.keys)

             forecast[:current].each do |key, value|
               if key != :temp
                 expect(value.class).to eq(current[key])
               else
                 expect(value.to_s.numeric?).to eq(true)
               end
             end
             forecast[:current][:weather][0].each do |key, value|
               expect(value.class).to eq(weather[key])
             end
          end

          it 'daily_weather' do
            daily = {
                      dt: Integer,
                      sunrise: Integer,
                      sunset: Integer,
                      temp: Hash,
                      feels_like: Hash,
                      pressure: Integer,
                      humidity: Integer,
                      dew_point: Float,
                      wind_speed: Float,
                      wind_deg: Integer,
                      weather: Array,
                      clouds: Integer,
                      pop: Float,
                      uvi: Float
                    }
            temp = {day: Float, min: Float, max: Float, night: Float, eve: Float, morn: Float}
            feels_like = {day: Float, night: Float, eve: Float, morn: Float}
            weather = {id: Integer, main: String, description: String, icon: String}

            expect(forecast[:daily][0].keys).to eq(daily.keys)
            expect(forecast[:daily][0][:temp].keys).to eq(temp.keys)
            expect(forecast[:daily][0][:feels_like].keys).to eq(feels_like.keys)
            expect(forecast[:daily][0][:weather][0].keys).to eq(weather.keys)

            forecast[:daily].each do |day|
              day.each do |key, value|
                if daily[key] == Integer || daily[key] == Float
                  expect(value.to_s.numeric?).to eq(true)
                else
                  expect(value.class).to eq(daily[key])
                end

                day[:temp].each do |key, value|
                  expect(value.to_s.numeric?).to eq(true)
                end

                day[:feels_like].each do |key, value|
                  expect(value.to_s.numeric?).to eq(true)
                end

                day[:weather][0].each do |key, value|
                  expect(value.class).to eq(weather[key])
                end
              end
            end
          end

          it 'hourly_weather' do
            hourly = {
                    dt: Integer,
                    temp: Float,
                    feels_like: Float,
                    pressure: Integer,
                    humidity: Integer,
                    dew_point: Float,
                    clouds: Integer,
                    visibility: Integer,
                    wind_speed: Float,
                    wind_deg: Integer,
                    weather: Array,
                    pop: Integer
                  }
            weather = {id: Integer, main: String, description: String, icon: String}

            expect(forecast[:hourly][0].keys).to eq(hourly.keys)
            expect(forecast[:hourly][0][:weather][0].keys).to eq(weather.keys)

            forecast[:hourly].each do |hour|
              hour.each do |key, value|
                if hourly[key] == Integer || hourly[key] == Float
                  expect(value.to_s.numeric?).to eq(true)
                else
                  expect(value.class).to eq(hourly[key])
                end

                hour[:weather][0].each do |key, value|
                  expect(value.class).to eq(weather[key])
                end
              end
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
