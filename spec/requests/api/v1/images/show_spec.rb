require 'rails_helper'

RSpec.describe 'image' do
  describe 'show' do
    before do
      VCR.turn_off!
      WebMock.allow_net_connect!
    end

    after do
      VCR.turn_on!
      WebMock.disable_net_connect!
    end

    it 'returns a json image' do
      get '/api/v1/backgrounds?location=Denver,CO&time=evening&weather=rainy'

      expect(response).to be_successful
      parsed_image = JSON.parse(response.body, symbolize_names: true)
      image_structure(parsed_image)
    end
  end
end
