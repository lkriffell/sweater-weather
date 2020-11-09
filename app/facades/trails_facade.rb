class TrailsFacade
  def self.trail_details(params)
    location = MapFacade.location_details(params['location'])
    trails = TrailsService.trail_details(location)
  end
end
