class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(road_trip_params, route, forecast)
    @start_city = road_trip_params[:origin]
    @end_city = road_trip_params[:destination]
    @travel_time = route[:route][:formattedTime]
    @weather_at_eta = {
        temperature: forecast.hourly_weather[rounded_travel_time][:temperature],
        conditions: forecast.hourly_weather[rounded_travel_time][:conditions]
    }
  end

  def rounded_travel_time
    time = @travel_time.split(':')
    hours = time[0].to_i
    mins = time[1].to_i
    if mins > 30
      hours += 1
    end
    hours
  end
end