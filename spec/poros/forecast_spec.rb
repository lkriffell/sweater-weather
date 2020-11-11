require 'rails_helper'

RSpec.describe 'forecast poro' do
  xit 'creates a poro out of a open weather request' do
    VCR.use_cassette 'forecast_poro' do
      # response = Faraday.get("#{ENV['OW_URL']}/data/2.5/onecall?lat=66&lon=42&exclude=minutely&units=imperial&appid=#{ENV['OW_API_KEY']}")
      forecast_details = File.read("spec/fixtures/weather.json")
      require "pry"; binding.pry
      forecast = Forecast.new(forecast_details)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.daily_weather).to be_a(Array)
      expect(forecast.hourly_weather).to be_a(Array)

      hour_one = {:temperature=>"29.32 F", :dt=>'Tue, 10 Nov 2020'.to_date, :wind_speed=>"10.54 mph", :wind_direction=>"NW", :conditions=>"clear sky", :icon=>"01n"}
      expect(forecast.hourly_weather.first).to eq(hour_one)

      day_one = {:dt=>'Wed, 11 Nov 2020'.to_date, :sunrise=>'Tue, 10 Nov 2020'.to_date, :sunset=>'Wed, 11 Nov 2020'.to_date, :max_temp=>"32.99 F", :min_temp=>"29.25 F", :conditions=>"overcast clouds", :icon=>"04d"}
      expect(forecast.daily_weather.first).to eq(day_one)

      current = {:dt=>'Tue, 10 Nov 2020'.to_date,
                 :sunrise=>'Tue, 10 Nov 2020'.to_date,
                 :sunset=>'Wed, 11 Nov 2020'.to_date,
                 :temp=>"32.13 F",
                 :feels_like=>"22.46 F",
                 :humidity=>95,
                 :uvi=>0.12,
                 :visibility=>1639,
                 :conditions=>"overcast clouds",
                 :icon=>"04n"}
       expect(forecast.current_weather).to eq(current)
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
