class ForecastService
  def self.forecast_details(location)
    conn.get("/data/2.5/onecall?lat=#{location.lat}&lon=#{location.lon}&exclude=minutely&units=imperial&appid=#{ENV['OW_API_KEY']}")
  end

  def self.conn
    Faraday.new(ENV['OW_URL'])
  end
end
