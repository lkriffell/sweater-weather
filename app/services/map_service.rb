class MapService
  def self.location_details(location)
    conn.get("/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{location}")
  end
  
  def self.route_details(from, to)
    conn.get("/directions/v2/route?key=#{ENV['MAPQUEST_API_KEY']}&from=#{from}&to=#{to}")
  end

  private

    def self.conn
      Faraday.new(ENV['MAP_URL'])
    end
end
