class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(forecast_params)
    @id = nil
    @current_weather = current(forecast_params)
    @daily_weather = []
    daily(forecast_params)
    @hourly_weather = []
    hourly(forecast_params)
  end

  def convert_date(date)
    Time.at(date).to_date
  end


  def determine_wind_direction(degrees)
    if degrees >= 330 || degrees < 30
      "N"
    elsif degrees >= 30 && degrees < 60
      "NE"
    elsif degrees >= 60 && degrees < 120
      "E"
    elsif degrees >= 120 && degrees < 150
      "SE"
    elsif degrees >= 150 && degrees < 210
      "S"
    elsif degrees >= 210 && degrees < 240
      "SW"
    elsif degrees >= 240 && degrees < 300
      "W"
    elsif degrees >= 300 && degrees < 330
      "NW"
    end
  end

  def current(forecast_params)
    {
      dt: convert_date(forecast_params[:current][:dt]),
      sunrise: convert_date(forecast_params[:current][:sunrise]),
      sunset: convert_date(forecast_params[:current][:sunset]),
      temp: forecast_params[:current][:temp],
      feels_like: forecast_params[:current][:feels_like],
      humidity: forecast_params[:current][:humidity],
      uvi: forecast_params[:current][:uvi],
      visibility: forecast_params[:current][:visibility],
      conditions: forecast_params[:current][:weather].first[:description],
      icon: forecast_params[:current][:weather].first[:icon]
    }
  end

  def daily(forecast_params)
    forecast_params[:daily].take(5).each do |forecast|
      daily_hash = {
        dt: convert_date(forecast[:dt]),
        sunrise: convert_date(forecast[:sunrise]),
        sunset: convert_date(forecast[:sunset]),
        max_temp: forecast[:temp][:max],
        min_temp: forecast[:temp][:min],
        conditions: forecast[:weather].first[:description],
        icon: forecast[:weather].first[:icon]
      }
      @daily_weather << daily_hash
    end
  end

  def hourly(forecast_params)
    forecast_params[:hourly].take(8).each do |forecast|
      hourly_hash = {
        dt: convert_date(forecast[:dt]),
        wind_speed: forecast[:wind_speed],
        wind_direction: determine_wind_direction(forecast[:wind_deg]),
        conditions: forecast[:weather].first[:description],
        icon: forecast[:weather].first[:icon]
      }
      @hourly_weather << hourly_hash
    end
  end
end
