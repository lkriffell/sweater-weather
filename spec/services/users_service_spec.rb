require 'rails_helper'

RSpec.describe 'users service' do
  it 'can create a user' do
    User.delete_all

    params = {
              email: 'email@email.com',
              password: 'password'
            }

    user = UsersService.create_user(params)

    expect(user.email).to eq(params[:email])
    expect(user.password).to eq(params[:password])
    expect(user.api_key).to be_a(String)
    expect(user.email).to be_a(String)
    expect(user.password).to be_a(String)
  end
end
