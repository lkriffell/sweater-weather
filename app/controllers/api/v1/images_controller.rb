class Api::V1::ImagesController < ApplicationController

  def show
    image = ImageFacade.image_details(params)
    render json: ImageSerializer.new(image)
  end
end
