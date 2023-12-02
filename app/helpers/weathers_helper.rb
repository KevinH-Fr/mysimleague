module WeathersHelper
    def weather_data(latitude, longitude)
        if latitude.present? && longitude.present?
            client = OpenWeather::Client.new(
                api_key: ENV["WEATHER_API_KEY"],
                units: 'metric',
                temperature_format: 'celsius'
            )
            client.current_weather(lat: latitude, lon: longitude)
        end
    end
end