require 'rails_helper'

RSpec.describe 'sessions' do
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
      User.create({
                  email: 'email@gmail.com',
                  password: 'password',
                  api_key: User.generate_api_key
                  })

      params = {
                  email: 'email@gmail.com',
                  password: 'password'
                }

      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v1/sessions', headers: headers, params: params.to_json

      expect(response).to be_successful
      parsed_user = JSON.parse(response.body, symbolize_names: true)
      user_structure(parsed_user)
    end
    it 'cannot return a json user with invalid password' do
      User.delete_all
      User.create({
                  email: 'email@gmail.com',
                  password: 'password',
                  api_key: User.generate_api_key
                  })

      params = {
                  email: 'email@gmail.com',
                  password: 'word'
                }

      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v1/sessions', headers: headers, params: params.to_json

      expect(response).to be_successful
      parsed_error = JSON.parse(response.body, symbolize_names: true)
      error_structure(parsed_error)
    end
    it 'cannot return a json user with invalid email' do
      User.delete_all
      User.create({
                  email: 'email@gmail.com',
                  password: 'password',
                  api_key: User.generate_api_key
                  })

      params = {
                  email: 'invalid@gmail.com',
                  password: 'password'
                }

      headers = {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }

      post '/api/v1/sessions', headers: headers, params: params.to_json

      expect(response).to be_successful
      parsed_error = JSON.parse(response.body, symbolize_names: true)
      error_structure(parsed_error)
    end
  end
end
