require 'rails_helper'

RSpec.describe 'user' do
  describe 'create' do
    before do
      VCR.turn_off!
      WebMock.allow_net_connect!
    end

    after do
      VCR.turn_on!
      WebMock.disable_net_connect!
    end

    it 'returns a json user' do
      User.delete_all

      params = {
                  email: 'email@gmail.com',
                  password: 'password',
                  password_confirmation: "password"
                }

      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v1/users', headers: headers, params: params.to_json

      expect(response).to be_successful
      parsed_user = JSON.parse(response.body, symbolize_names: true)
      user_structure(parsed_user)
    end
  end
end
