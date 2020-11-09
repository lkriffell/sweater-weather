require 'rails_helper'

RSpec.describe 'forecast poro' do
  it 'creates a poro out of a open weather request' do
    VCR.use_cassette 'forecast_poro' do
      response = Faraday.get("#{ENV['OW_URL']}/data/2.5/onecall?lat=66&lon=42&exclude=minutely&units=imperial&appid=#{ENV['OW_API_KEY']}")
      forecast_details = JSON.parse(response.body, symbolize_names: true)

      forecast = Forecast.new(forecast_details)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.daily_weather).to be_a(Array)
      expect(forecast.hourly_weather).to be_a(Array)
    end
  end

  describe 'poro_methods' do
    it 'determine_wind_direction' do
      VCR.use_cassette 'forecast_poro' do
        response = Faraday.get("#{ENV['OW_URL']}/data/2.5/onecall?lat=66&lon=42&exclude=minutely&units=imperial&appid=#{ENV['OW_API_KEY']}")
        forecast_details = JSON.parse(response.body, symbolize_names: true)

        forecast = Forecast.new(forecast_details)
        
        expect(forecast.determine_wind_direction(360)).to eq("N")
        expect(forecast.determine_wind_direction(40)).to eq("NE")
        expect(forecast.determine_wind_direction(77)).to eq("E")
        expect(forecast.determine_wind_direction(140)).to eq("SE")
        expect(forecast.determine_wind_direction(180)).to eq("S")
        expect(forecast.determine_wind_direction(220)).to eq("SW")
        expect(forecast.determine_wind_direction(255)).to eq("W")
        expect(forecast.determine_wind_direction(315)).to eq("NW")
      end
    end
  end
end
