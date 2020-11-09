require 'rails_helper'

RSpec.describe 'trails service spec' do
  it 'recieves data and can be converted to json' do
    VCR.use_cassette 'trails_response' do
      params = { 'location': 'denver,co' }
      location_params = { results:
                          [  locations: [
                            latLng: { lat: 39, lng: -105 }  ]  ]
                        }
      location = Location.new(location_params)
      trails_response = TrailsService.trail_details(location)

      trails = JSON.parse(trails_response.body, symbolize_names: true)

      trails_keys = {
                    :id=>Integer,
                    :name=>String,
                    :type=>String,
                    :summary=>String,
                    :difficulty=>String,
                    :stars=>Float,
                    :starVotes=>Integer,
                    :location=>String,
                    :url=>String,
                    :imgSqSmall=>String,
                    :imgSmall=>String,
                    :imgSmallMed=>String,
                    :imgMedium=>String,
                    :length=>Float,
                    :ascent=>Integer,
                    :descent=>Integer,
                    :high=>Integer,
                    :low=>Integer,
                    :longitude=>Float,
                    :latitude=>Float,
                    :conditionStatus=>String,
                    :conditionDetails=>String,
                    :conditionDate=>String
                    }

      trails[:trails].each do |trail|
        expect(trail.keys).to eq(trails_keys.keys)
        trail.each do |key, value|
          if trail[key] != nil
            if trail[key].class == Integer || trail[key].class == Integer
              expect([Float, Integer]).to include(trail[key].class)
            else
              expect(trail[key].class).to eq(trails_keys[key])
            end
          end
        end
      end
    end
  end
end
