require 'rails_helper'

RSpec.describe 'road_trip' do
  describe 'create' do
    it 'returns a json road_trip' do
      VCR.use_cassette 'road_trip_endpoint' do
        User.create({
                    email: 'email@gmail.com',
                    password: 'password',
                    api_key: "jgn983hy48thw9begh98h4539h4"
                    })

        params = {
                    "origin": "Denver CO",
                    "destination": "Pueblo CO",
                    "api_key": "jgn983hy48thw9begh98h4539h4"
                  }

        headers = {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json'
        }

        post '/api/v1/road_trip', headers: headers, params: params.to_json

        expect(response).to be_successful
        parsed_road_trip = JSON.parse(response.body, symbolize_names: true)
        road_trip_structure(parsed_road_trip)
      end
    end
  end
end
