class TrailsService
  def self.trail_details(location)
    conn.get("/data/get-trails?lat=#{location.lat}&lon=#{location.lon}&key=#{ENV['HIKING_API_KEY']}")
  end

  def self.conn
    Faraday.new('https://www.hikingproject.com')
  end
end
