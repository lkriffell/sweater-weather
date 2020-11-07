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
end
