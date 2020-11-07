require 'rails_helper'

RSpec.describe 'map service' do
  describe 'location_details' do
    it 'returns a json response' do
      VCR.use_cassette 'denver_co' do
        params = {location: 'denver,co'}
        response = MapService.location_details(params[:location])

        expect(response).to be_success
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        keys = {results: Array,
                locations: Array,
                latLng: Hash,
                lat: Float,
                lng: Float}

        expect(parsed_response[:results].class).to eq(keys[:results])
        expect(parsed_response[:results].first[:locations].class).to eq(keys[:locations])
        expect(parsed_response[:results].first[:locations].first[:latLng].class).to eq(keys[:latLng])
        expect(parsed_response[:results].first[:locations].first[:latLng][:lat].class).to eq(keys[:lat])
        expect(parsed_response[:results].first[:locations].first[:latLng][:lng].class).to eq(keys[:lng])
      end
    end
  end
end
