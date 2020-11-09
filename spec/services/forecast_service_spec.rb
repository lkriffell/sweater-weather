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
                       dt:[Integer, Float],
                       sunrise:[Integer, Float],
                       sunset:[Integer, Float],
                       temp:[Integer, Float],
                       feels_like:[Integer, Float],
                       pressure:[Integer, Float],
                       humidity:[Integer, Float],
                       dew_point:[Integer, Float],
                       uvi:[Integer, Float],
                       clouds:[Integer, Float],
                       visibility:[Integer, Float],
                       wind_speed:[Integer, Float],
                       wind_deg:[Integer, Float],
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
               if value.class == Integer || value.class == Float
                 expect(current[key]).to include(value.class)
               else
                 expect(value.class).to eq(current[key])
               end
             end
             forecast[:current][:weather][0].each do |key, value|
               expect(value.class).to eq(weather[key])
             end
          end

          it 'daily_weather' do
            daily = {
                      dt: [Integer, Float],
                      sunrise: [Integer, Float],
                      sunset: [Integer, Float],
                      temp: Hash,
                      feels_like: Hash,
                      pressure: [Integer, Float],
                      humidity: [Integer, Float],
                      dew_point: [Integer, Float],
                      wind_speed: [Integer, Float],
                      wind_deg: [Integer, Float],
                      weather: Array,
                      clouds: [Integer, Float],
                      pop: [Integer, Float],
                      uvi: [Integer, Float]
                    }
            temp = {day: [Integer, Float], min: [Integer, Float], max: [Integer, Float], night: [Integer, Float], eve: [Integer, Float], morn: [Integer, Float]}
            feels_like = {day: [Integer, Float], night: [Integer, Float], eve: [Integer, Float], morn: [Integer, Float]}
            weather = {id: Integer, main: String, description: String, icon: String}

            expect(forecast[:daily][0].keys).to eq(daily.keys)
            expect(forecast[:daily][0][:temp].keys).to eq(temp.keys)
            expect(forecast[:daily][0][:feels_like].keys).to eq(feels_like.keys)
            expect(forecast[:daily][0][:weather][0].keys).to eq(weather.keys)

            forecast[:daily].each do |day|
              day.each do |key, value|
                if value.class == Integer || value.class == Float
                  expect(daily[key]).to include(value.class)
                else
                  expect(value.class).to eq(daily[key])
                end

                day[:temp].each do |key, value|
                  expect(temp[key]).to include(value.class)
                end

                day[:feels_like].each do |key, value|
                  expect(feels_like[key]).to include(value.class)
                end

                day[:weather][0].each do |key, value|
                  expect(value.class).to eq(weather[key])
                end
              end
            end
          end

          it 'hourly_weather' do
            hourly = {
                    dt: [Integer, Float],
                    temp: [Integer, Float],
                    feels_like: [Integer, Float],
                    pressure: [Integer, Float],
                    humidity: [Integer, Float],
                    dew_point: [Integer, Float],
                    clouds: [Integer, Float],
                    visibility: [Integer, Float],
                    wind_speed: [Integer, Float],
                    wind_deg: [Integer, Float],
                    weather: Array,
                    pop: [Integer, Float]
                  }
            weather = {id: Integer, main: String, description: String, icon: String}

            expect(forecast[:hourly][0].keys).to eq(hourly.keys)
            expect(forecast[:hourly][0][:weather][0].keys).to eq(weather.keys)

            forecast[:hourly].each do |hour|
              hour.each do |key, value|
                if value.class == Integer || value.class == Float
                  expect(hourly[key]).to include(value.class)
                else
                  if key == :rain
                    expect(hour[:rain]).to be_a(Hash)
                  else
                    expect(value.class).to eq(hourly[key])
                  end
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
