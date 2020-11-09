class Api::V1::SessionsController < ApplicationController
  def create
    user = UsersFacade.check_credentials(user_params)
    if user.class == User
      render json: UserSerializer.new(user)
    elsif user.class == Error
      render json: ErrorSerializer.new(user)
    end
  end

  private

  def user_params
    JSON.parse(request.raw_post, symbolize_names: true)
  end
end
