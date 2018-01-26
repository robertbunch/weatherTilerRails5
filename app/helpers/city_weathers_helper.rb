# A helper module to put all the http requests in one place
module CityWeathersHelper
  def get_weather(city, query_type)
  	# Include http service,json,cgi (part of core Rails)
    require 'net/http'
    require 'json'
    require 'cgi'
  	weather_api_key = Rails.application.config_for(:weather)['api_key']
  	# Set up URL's
  	puts '--------CITY--------'
  	puts city
  	safe_city = CGI.escape(city.to_s)
    base_url = url = "https://api.openweathermap.org/data/2.5/forecast/daily?appid=#{weather_api_key}&units=imperial&"
    full_url = "#{base_url}#{query_type}=#{safe_city}"
    # Print/test out the finished URL
  	puts '============FULL URL============='
  	puts full_url
  	puts '=================================='

  	# Convert the url string to make Rails happy
    uri = URI(full_url)
    response = Net::HTTP.get(uri)
    return response
  end
end

