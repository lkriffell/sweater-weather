require 'rails_helper'

RSpec.describe 'users facade' do
  before :each do
    User.delete_all
  end
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

    expect(user.message).to be_a(String)
  end
  it 'returns an error if email already exists' do
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "word"
    }

    user = UsersFacade.create_user(params)
    user = UsersFacade.create_user(params)

    expect(user.message).to be_a(String)
  end
end
