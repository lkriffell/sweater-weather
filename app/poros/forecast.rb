class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(forecast_params)
    @current_weather = {
      dt: convert_date(forecast_params[:current][:dt]),
      sunrise: convert_date(forecast_params[:current][:sunrise]),
      sunset: convert_date(forecast_params[:current][:sunset]),
      temp: kelvin_to_f(forecast_params[:current][:temp]),
      feels_like: kelvin_to_f(forecast_params[:current][:feels_like]),
      humidity: forecast_params[:current][:humidity],
      uvi: forecast_params[:current][:uvi],
      visibility: forecast_params[:current][:visibility],
      conditions: forecast_params[:current][:weather].first[:description],
      icon: forecast_params[:current][:weather].first[:icon]
    }

    @daily_weather = []
    forecast_params[:daily].take(5).each do |forecast|
      daily_hash = {
        dt: convert_date(forecast[:dt]),
        sunrise: convert_date(forecast[:sunrise]),
        sunset: convert_date(forecast[:sunset]),
        max_temp: kelvin_to_f(forecast[:temp][:max]),
        min_temp: kelvin_to_f(forecast[:temp][:min]),
        conditions: forecast[:weather].first[:description],
        icon: forecast[:weather].first[:icon]
      }
      @daily_weather << daily_hash
    end

    @hourly_weather = []
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

  def kelvin_to_f(kelvin)
    ((kelvin - 273.15) * 9/5 + 32).round(2)
  end

  def convert_date(date)
    Time.at(date).to_date
  end

  def determine_wind_direction(degrees)
    if degrees >= 315 && degrees < 45
      "North"
    elsif degrees >= 45 && degrees < 135
      "East"
    elsif degrees >= 135 && degrees < 225
      "South"
    elsif degrees >= 225 && degrees < 315
      "West"
    end
  end
end
# time, in a human-readable format such as “14:00:00”
# wind_speed, string, in miles per hour
# wind_direction, string, check wikipedia for how to convert this numeric value
# conditions, the first ‘description’ field from the weather data as given by OpenWeather
# icon, string, as given by OpenWeather
