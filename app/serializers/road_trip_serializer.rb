class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  set_id { 0 }

  attributes :start_city, :end_city, :travel_time, :weather_at_eta
end
