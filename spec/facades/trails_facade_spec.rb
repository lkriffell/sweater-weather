require 'rails_helper'

RSpec.describe 'trails facade spec' do
  VCR.use_cassette 'trails_response' do
    it 'recieves data and turns it into an array of poros' do

    end
  end
end
