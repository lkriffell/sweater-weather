require 'rails_helper'

RSpec.describe 'map facade' do
  describe 'location_details' do
    it 'returns a location poro' do
      VCR.use_cassette 'denver_co' do
        params = {location: 'denver,co'}
        location = MapFacade.location_details(params[:location])

        expect(location.lat).to be_a(Float)
        expect(location.lon).to be_a(Float)
      end
    end
  end
  describe 'road_trip' do
    before :each do
      User.create(email: 'email@gmail.com', password: 'password', api_key: 'jgn983hy48thw9begh98h4539h4')
    end
    it 'returns a road_trip object' do
      VCR.use_cassette 'road_trip' do
        params = {
                  "origin": "Denver,CO",
                  "destination": "Pueblo,CO",
                  "api_key": "jgn983hy48thw9begh98h4539h4"
                }

        road_trip = MapFacade.road_trip(params)

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.end_city).to be_a(String)
        expect(road_trip.start_city).to be_a(String)
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.weather_at_eta).to be_a(Hash)
        expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
        expect(road_trip.weather_at_eta[:conditions]).to be_a(String)
      end
    end
    it 'cannot return a road_trip object with invalid key' do
      VCR.use_cassette 'road_trip' do
        params = {
                  "origin": "Denver,CO",
                  "destination": "Pueblo,CO",
                  "api_key": "1234api5678key"
                }

        error = MapFacade.road_trip(params)

        expect(error).to be_an(Error)
        expect(error.message).to eq("That key is not valid!")
      end
    end
    it 'cannot return a road_trip object with impossible route' do
      VCR.use_cassette 'impossible_road_trip' do
        params = {
                  "origin": "Denver,CO",
                  "destination": "Paris,France",
                  "api_key": "jgn983hy48thw9begh98h4539h4"
                }

        error = MapFacade.road_trip(params)

        expect(error).to be_an(Error)
        expect(error.message).to eq("Impossible Route!")
      end
    end
  end
end
