class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(road_trip_params, route, forecast)
    @start_city = road_trip_params[:origin]
    @end_city = road_trip_params[:destination]
    @travel_time = route[:route][:formattedTime]
    @weather_at_eta = check_the_weather(forecast)
  end

  def eta
    time = @travel_time.split(':')
    hours = time[0].to_i
    mins = time[1].to_i
    if mins > 30
      hours += 1
    end
    hours
  end

  def enough_hours?(hours_of_weather)
    if eta > hours_of_weather.size
      false
    else
      true
    end
  end

  def check_the_weather(forecast)
    if enough_hours?(forecast.hourly_weather)
      @weather_at_eta = {temperature: forecast.hourly_weather[eta][:temperature],
                     conditions: forecast.hourly_weather[eta][:conditions]}
    else
      days_ahead =  (eta / 24.0).round
      temperature = avg_temp(forecast, days_ahead)
      @weather_at_eta = {temperature: temperature,
                     conditions: forecast.daily_weather[days_ahead][:conditions]}
    end
  end

  def avg_temp(forecast, days_ahead)
    max = forecast.daily_weather[days_ahead][:max_temp]
    min = forecast.daily_weather[days_ahead][:min_temp]
    "#{((min + max) / 2).round} F"
  end
end
