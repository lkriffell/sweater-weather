require 'rails_helper'

RSpec.describe 'users facade' do
  before :each do
    User.delete_all
  end
  describe 'registration' do
    it 'returns a user object' do
      params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }

      user = UsersFacade.create_user(params)

      expect(User.count).to eq(1)

      expect(user.email).to be_a(String)
      expect(user.password).to be_a(String)
      expect(user.api_key).to be_a(String)
    end
    it 'returns an error if passwords dont match' do
      params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "word"
      }

      user = UsersFacade.create_user(params)

      expect(user.message).to eq('Passwords must match!')
    end
    it 'returns an error if email already exists' do
      params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }

      user = UsersFacade.create_user(params)
      user = UsersFacade.create_user(params)

      expect(user.message).to eq('That email already exists!')
    end
  end

  describe 'logging in' do
    before :each do
      params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      UsersFacade.create_user(params)
    end
    it 'can successfully log in' do
      params = {
        "email": "whatever@example.com",
        "password": "password"
      }
      user = UsersFacade.check_credentials(params)

      expect(user).to be_a(User)
      expect(user.email).to eq(params[:email])
    end
    it 'returns an error if passwords dont match' do
      params = {
        "email": "whatever@example.com",
        "password": "word"
      }
      error = UsersFacade.check_credentials(params)

      expect(error.message).to eq('That email and password combination does not exist!')
    end
    it 'returns an error if email doesnt exist' do
      params = {
        "email": "nothing@example.com",
        "password": "password"
      }
      error = UsersFacade.check_credentials(params)

      expect(error.message).to eq('That email and password combination does not exist!')
    end
  end
end
