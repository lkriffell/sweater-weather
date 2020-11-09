require 'rails_helper'

RSpec.describe 'image poro' do
  it 'can exist' do
    image_params = {urls: {raw: "A picture link"},
                    user: {username: "Logan"}
                  }
    image = Image.new(image_params, "Denver")

    expect(image.credit[:source]).to eq('https://unsplash.com')
    expect(image.credit[:author]).to eq("Logan")
    expect(image.credit[:logo]).to eq('https://unsplash.com/photos/YYUM2sNvnvU')
    expect(image.image_url).to eq("A picture link")
    expect(image.location).to eq("Denver")
  end
end
