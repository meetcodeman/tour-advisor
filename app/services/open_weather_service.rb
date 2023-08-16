class OpenWeatherService
  def initialize(lat, long)
    @lat = lat
    @long = long
  end

  def weather_data
    response = client.current_weather(lat: @lat, lon: @long)

    {
      lat: response.coord.lat,
      long: response.coord.lon,
      feels_like: response.weather.first.description,
      temp_in_c: response.main.temp_max_c,
      city: response.name,
      country: response.sys.country
    }
  end

  private

  def client
    @client ||= OpenWeather::Client.new(api_key: ENV['OPEN_WEATHER_API_KEY'])
  end
end
