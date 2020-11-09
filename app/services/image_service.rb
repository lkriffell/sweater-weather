class ImageService
  def self.image_details(params)
    if params['time'] && params['weather']
      conn.get("/search?client_id=#{ENV['IMAGE_API_KEY']}&query=#{params['location']}&query=#{params['time']}&query=#{params['weather']}")
    elsif params['time'] && !params['weather']
      conn.get("/search?client_id=#{ENV['IMAGE_API_KEY']}&query=#{params['location']}&query=#{params['time']}")
    elsif params['weather'] && !params['time']
      conn.get("/search?client_id=#{ENV['IMAGE_API_KEY']}&query=#{params['location']}&query=#{params['weather']}")
    else
      conn.get("/search?client_id=#{ENV['IMAGE_API_KEY']}&query=#{params['location']}")
    end
  end

  def self.conn
    Faraday.new("https://api.unsplash.com/photos")
  end

  def check_for_keyword
    params['keyword']
  end
end
