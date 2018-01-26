json.extract! city_weather, :id, :cityName, :zipCode, :desc, :created_at, :updated_at
json.url city_weather_url(city_weather, format: :json)
