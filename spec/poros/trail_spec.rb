require 'rails_helper'

RSpec.describe 'trail poro spec' do
  it 'can create a poro out of parsed json' do
    VCR.use_cassette 'trails.yml' do
      location_params = { results:
                          [  locations: [
                            latLng: { lat: 39, lng: -105 }  ]  ]
                        }
      location = Location.new(location_params)
      trails = TrailsFacade.trail_details(location, 'denver,co')

      expect(trails.class).to eq(Array)

      expect(trails.first.class).to eq(Trail)

      trails.each do |trail|
        expect(trail.class).to eq(Trail)
        expect(trail.name.class).to eq(String)
        expect(trail.summary.class).to eq(String)
        expect(trail.difficulty.class).to eq(String)
        expect(trail.location.class).to eq(String)
        expect(trail.current_conditions.class).to eq(Array)
        expect(trail.current_conditions.first.class).to eq(String)
        expect(trail.current_conditions.last.class).to eq(String)
        expect(trail.distance_to_trail.class).to eq(Route)
      end
    end
  end
end
