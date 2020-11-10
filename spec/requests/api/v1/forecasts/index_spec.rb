require 'rails_helper'

RSpec.describe 'forecast' do
  describe 'index' do
    before do
      VCR.turn_off!
      WebMock.allow_net_connect!
    end

    after do
      VCR.turn_on!
      WebMock.disable_net_connect!
    end

    it 'returns a json forecast' do
      get '/api/v1/forecast?location=Denver,CO'

      expect(response).to be_successful
      parsed_forecast = JSON.parse(response.body, symbolize_names: true)
      forecast_structure(parsed_forecast)
    end
  end
end
