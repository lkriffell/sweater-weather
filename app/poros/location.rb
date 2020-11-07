class Location
  attr_reader :lat,
              :lon

  def initialize(location_params)
    @lat = location_params[:results].first[:locations].first[:latLng][:lat]
    @lon = location_params[:results].first[:locations].first[:latLng][:lng]
  end
end
