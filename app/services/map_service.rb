class MapService
  def self.location_details(location)
    conn.get("/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&exclude=minutely&location=#{location}")
  end

  private

    def self.conn
      Faraday.new(ENV['MAP_URL'])
    end
end
