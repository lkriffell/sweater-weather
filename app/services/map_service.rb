class MapService
  def self.location_details(location)
    conn.get("/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&exclude=minutely&location=#{location}")
  end

  def self.route_details(origin, destination)
    conn.get("/directions/v2/route?key=#{ENV['MAPQUEST_API_KEY']}&from=#{origin}&to=#{destination}")
  end

  private

    def self.conn
      Faraday.new(ENV['MAP_URL'])
    end
end
