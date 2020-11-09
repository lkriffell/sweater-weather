class Api::V1::UsersController < ApplicationController
  def create
    user = UsersFacade.create_user(user_params)
    if user.class == User && user.save
      render json: UserSerializer.new(user)
    elsif user.message == 'Passwords must match!'
      render json: ErrorSerializer.new(user)
    elsif user.message == 'That email already exists!'
      render json: ErrorSerializer.new(user)
    end
  end

  private

  def user_params
    JSON.parse(request.raw_post, symbolize_names: true)
  end
end
