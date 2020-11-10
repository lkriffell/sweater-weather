require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'poro' do
    before :each do
      User.create(email: 'email@gmail.com', password: 'password', api_key: 'jgn983hy48thw9begh98h4539h4')
    end

    it 'can exist' do
      VCR.use_cassette 'custom_hours_forecast', :record => :none do
        forecast = ForecastFacade.forecast_details_50_hours("Pueblo,CO")
        road_trip_params = {:origin=>"Denver,CO", :destination=>"Pueblo,CO", :api_key=>"jgn983hy48thw9begh98h4539h4"}
        route = {route: {formattedTime: "01:43:57"}}

        road_trip = RoadTrip.new(road_trip_params, route, forecast)

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.end_city).to eq("Pueblo,CO")
        expect(road_trip.start_city).to eq("Denver,CO")
        expect(road_trip.travel_time).to eq("01:43:57")
        expect(road_trip.weather_at_eta[:temperature]).to eq(49.24)
        expect(road_trip.weather_at_eta[:conditions]).to eq("clear sky")
      end
    end
  end
end
