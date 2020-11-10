module Structures
  def forecast_structure(forecast)
    require "pry"; binding.pry
  end
  def image_structure
  end
  def road_trip_structure(road_trip)
    expect(road_trip).to have_key(:data)
    expect(road_trip[:data]).to be_a(Hash)

    expect(road_trip[:data]).to have_key(:id)
    expect(road_trip[:data][:id]).to be_a(String)

    expect(road_trip[:data]).to have_key(:type)
    expect(road_trip[:data][:type]).to eq("road_trip")

    expect(road_trip[:data]).to have_key(:attributes)
    expect(road_trip[:data][:attributes]).to be_a(Hash)

    expect(road_trip[:data][:attributes]).to have_key(:start_city)
    expect(road_trip[:data][:attributes][:start_city]).to be_a(String)

    expect(road_trip[:data][:attributes]).to have_key(:end_city)
    expect(road_trip[:data][:attributes][:end_city]).to be_a(String)

    expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)

    expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
    expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)

    expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(String)

    expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
  end
end
