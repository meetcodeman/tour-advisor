class OpenWeatherService
  attr_reader :client

  def initialize(options)
    @long = options[:long]
    @lat = options[:lat]
    @city_name = options[:city_name]
  end

  def get_weather_info
    if @long && @lat
      get_weather_from_long_lat
    elsif @city_name      
      get_weather_from_name
    end
  end

  private

  def get_weather_from_long_lat
    client.current_weather(lat: @lat, lon: @long)
  end

  def get_weather_from_name
    client.current_weather(city: @city_name)
  end

  def client
    @client ||= OpenWeather::Client.new(api_key: ENV['OPEN_WEATHER_API_KEY'])
  end
end
