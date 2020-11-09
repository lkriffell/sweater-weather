class MapFacade
  def self.location_details(location)
    response = MapService.location_details(location)
    create_location(JSON.parse(response.body, symbolize_names: true))
  end

  def self.route_details(from, to)
    response = MapService.route_details(from, to)
    create_route(JSON.parse(response.body, symbolize_names: true))
  end

  def self.create_route(route)
    Route.new(route)
  end

  def self.create_location(location)
    Location.new(location)
  end
end
