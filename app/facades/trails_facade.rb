class TrailsFacade
  def self.trail_details(location, start_location)
    trails = JSON.parse(TrailsService.trail_details(location).body, symbolize_names: true)
    map_trails(trails[:trails], start_location)
  end

  def self.map_trails(trails, start_location)
    trails.map do |trail|
      Trail.new(trail, start_location)
    end
  end
end
