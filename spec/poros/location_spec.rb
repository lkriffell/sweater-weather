require 'rails_helper'

RSpec.describe 'location poro' do
  it 'creates a poro out of a map quest request' do
    VCR.use_cassette 'denver_co' do
      response = Faraday.get("#{ENV['MAP_URL']}/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=denver,co")
      location_details = JSON.parse(response.body, symbolize_names: true)

      location = Location.new(location_details)

      expect(location.lat).to be_a(Float)
      expect(location.lon).to be_a(Float)
    end
  end
end
