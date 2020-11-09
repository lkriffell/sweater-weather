require 'rails_helper'

RSpec.describe 'image service' do
  it 'returns an unparsed response' do
    VCR.use_cassette 'image_service' do
      params = {'location' => 'Denver', 'time' => 'evening', 'weather' => 'sunny'}

      image_response = ImageService.image_details(params)

      expect(image_response).to be_success
    end
  end
  it 'returns an unparsed response with only location' do
    VCR.use_cassette 'image_service_location_only' do
      params = {'location' => 'Denver'}

      image_response = ImageService.image_details(params)

      expect(image_response).to be_success
    end
  end
  it 'returns an unparsed response with only location' do
    VCR.use_cassette 'image_service_location_and_weather_only' do
      params = {'location' => 'Denver', 'weather' => 'sunny'}

      image_response = ImageService.image_details(params)

      expect(image_response).to be_success
    end
  end
end
