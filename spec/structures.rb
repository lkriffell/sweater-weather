module Structures
  def forecast_structure(forecast)
    current = {dt: String,
             sunrise: String,
             sunset: String,
             temp: String,
             feels_like: String,
             humidity: Integer,
             uvi: Float,
             visibility: Integer,
             conditions: String,
             icon: String}

    daily = {dt: String, sunrise: String, sunset: String, max_temp: Float, min_temp: Float, conditions: String, icon: String}
    hourly = {temperature: String, dt: String, wind_speed: String, wind_direction: String, conditions: String, icon: String}

    expect(forecast[:data]).to be_a(Hash)
    expect(forecast[:data]).to have_key(:id)
    expect(forecast[:data][:id]).to eq(nil)

    expect(forecast[:data]).to have_key(:type)
    expect(forecast[:data][:type]).to eq("forecast")

    expect(forecast[:data]).to have_key(:attributes)
    expect(forecast[:data][:attributes]).to be_a(Hash)

    expect(forecast[:data][:attributes]).to have_key(:current_weather)
    expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
    expect(forecast[:data][:attributes][:current_weather].keys).to eq(current.keys)
    forecast[:data][:attributes][:current_weather].each do |key, value|
      expect(value).to be_a(current[key])
    end

    expect(forecast[:data][:attributes]).to have_key(:daily_weather)
    expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
    expect(forecast[:data][:attributes][:daily_weather][0]).to be_an(Hash)

    forecast[:data][:attributes][:daily_weather].each do |day|
      day.each do |key, value|
        expect(value).to be_a(daily[key])
        expect(daily.keys).to include(key)
      end
    end

    expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
    expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)
    expect(forecast[:data][:attributes][:hourly_weather][0]).to be_an(Hash)

    forecast[:data][:attributes][:hourly_weather].each do |hour|
      hour.each do |key, value|
        expect(hourly.keys).to include(key)
        expect(value).to be_a(hourly[key])
      end
    end
  end

  def image_structure(image)
    attributes = {
                  image_url: String,
                  location: String,
                  credit: Hash
                }
    credit = {source: String, author: String, logo: String}

    expect(image).to have_key(:data)
    expect(image[:data]).to have_key(:id)
    expect(image[:data][:id]).to eq(nil)

    expect(image[:data]).to have_key(:type)
    expect(image[:data][:type]).to eq("image")

    expect(image[:data]).to have_key(:attributes)
    expect(image[:data][:attributes]).to be_a(Hash)

    image[:data][:attributes].each do |key, value|
      expect(attributes.keys).to include(key)
      expect(value).to be_a(attributes[key])
    end

    image[:data][:attributes][:credit].each do |key, value|
      expect(credit.keys).to include(key)
      expect(value).to be_a(credit[key])
    end
  end

  def road_trip_structure(road_trip)
    expect(road_trip).to have_key(:data)
    expect(road_trip[:data]).to be_a(Hash)

    expect(road_trip[:data]).to have_key(:id)
    expect(road_trip[:data][:id]).to eq(nil)

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

  def user_structure(user)
    expect(user).to have_key(:data)
    expect(user[:data]).to be_a(Hash)

    expect(user[:data]).to have_key(:id)
    expect(user[:data][:id]).to be_a(String)

    expect(user[:data]).to have_key(:type)
    expect(user[:data][:type]).to eq("user")

    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes]).to be_a(Hash)

    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes][:email]).to be_a(String)

    expect(user[:data][:attributes]).to have_key(:api_key)
    expect(user[:data][:attributes][:api_key]).to be_a(String)

    expect(user[:data][:attributes]).to_not have_key(:password)
    expect(user[:data][:attributes]).to_not have_key(:password_confirmation)
  end

  def error_structure(error)
    expect(error).to have_key(:data)
    expect(error[:data]).to be_a(Hash)

    expect(error[:data]).to have_key(:id)
    expect(error[:data][:id]).to eq(nil)

    expect(error[:data]).to have_key(:type)
    expect(error[:data][:type]).to eq("error")

    expect(error[:data]).to have_key(:attributes)
    expect(error[:data][:attributes]).to be_a(Hash)

    expect(error[:data][:attributes]).to have_key(:message)
    expect(error[:data][:attributes][:message]).to be_a(String)
  end
end
