require 'net/http'
require 'json'
require 'dotenv/load'

api_key = ENV['SERPAPI_KEY']

query = 'PAF Museum'
url = URI("https://serpapi.com/search?engine=google_maps&q=#{URI.encode(query)}&api_key=#{api_key}")

response = Net::HTTP.get(url)
result = JSON.parse(response)

title = result.dig('place_results', 'title')
puts "Name: #{title}" if title

rating = result.dig('place_results', 'rating')
puts "Rating: #{rating}" if rating

reviews = result.dig('place_results', 'reviews')
puts "Reviews: #{reviews}" if reviews

puts

hours = result.dig('place_results', 'hours') || []
puts "Open Hours: 👇"
hours.each do |day_hash|
  day_hash.each do |day, time|
    puts "#{day}: #{time}"
  end
end
