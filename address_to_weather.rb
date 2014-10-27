require 'open-uri'
require 'json'

# If you experience an error relating to SSL,
#   uncomment the following two lines:

require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

puts "Let's get the weather forecast for your address."

puts "What is the address you would like to know the weather for?"
the_address = gets.chomp
url_safe_address = URI.encode(the_address)

# Your code goes below.

url_of_geo_data = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_address
raw_geo_data = open(url_of_geo_data).read
parsed_geo_data = JSON.parse(raw_geo_data)

the_latitude = parsed_geo_data["results"][0]["geometry"]["location"]["lat"]
the_longitude = parsed_geo_data["results"][0]["geometry"]["location"]["lng"]

url_of_weather_data = "https://api.forecast.io/forecast/cde2501b2b09bfe2cff0e52364691e70/" + the_latitude.to_s + "," + the_longitude.to_s
raw_weather_data = open(url_of_weather_data).read
parsed_weather_data = JSON.parse(raw_weather_data)

the_temperature = parsed_weather_data["currently"]["temperature"]
the_hour_outlook = parsed_weather_data["hourly"]["summary"]
the_day_outlook = parsed_weather_data["daily"]["summary"]

# Ultimately, we want the following line to work when uncommented:

puts "The current temperature at #{the_address} is #{the_temperature} degrees."
puts "The outlook for the next hour is: #{the_hour_outlook}"
puts "The outlook for the next day is: #{the_day_outlook}"
