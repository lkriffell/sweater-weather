class ImageFacade
  def self.image_details(params)
    response = ImageService.image_details(params)
    Image.new(JSON.parse(response.body, symbolize_names: true)[:photos][:results].first, params['location'])
  end
end
