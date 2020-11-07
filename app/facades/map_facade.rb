class MapFacade
  def self.location_details(location)
    response = MapService.location_details(location)
    create_location(JSON.parse(response.body, symbolize_names: true))
  end

  def self.create_location(location)
    Location.new(location)
  end
end
