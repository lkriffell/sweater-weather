require 'rails_helper'

RSpec.describe User, type: :model do
  it 'exists' do
    User.delete_all
    
    params = {
              email: "logan@gmail.com",
              password: "password",
              password_confirmation: "password",
              api_key: User.generate_api_key
            }

    user = User.create(params)

    expect(User.count).to eq(1)
    expect(user.email).to eq(params[:email])
    expect(user.password).to eq(params[:password])
    expect(user.api_key).to eq(params[:api_key])
  end
end
