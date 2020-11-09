class Image
  attr_reader :image_url,
              :location,
              :credit

  def initialize(image_params, location)
    @image_url = image_params[:urls][:raw]
    @location = location
    @credit = {
      source: 'https://unsplash.com',
      author: image_params[:user][:username],
      logo: 'https://unsplash.com/photos/YYUM2sNvnvU'
    }
  end

end
