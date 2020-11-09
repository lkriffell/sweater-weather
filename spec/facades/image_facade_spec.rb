require 'rails_helper'

RSpec.describe 'images facade' do
  it 'returns an image poro' do
    VCR.use_cassette 'image' do
      params = {'location' => 'Denver', 'time' => 'evening'}
      image = ImageFacade.image_details(params)

      expect(image).to be_an(Image)
      expect(image.credit).to be_a(Hash)
      expect(image.credit[:source]).to be_a(String)
      expect(image.credit[:author]).to be_a(String)
      expect(image.credit[:logo]).to be_a(String)
      expect(image.image_url).to be_a(String)
      expect(image.location).to be_a(String)
    end
  end
end
