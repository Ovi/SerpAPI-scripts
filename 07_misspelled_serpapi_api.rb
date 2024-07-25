require 'net/http'
require 'json'
require 'dotenv/load'

api_key = ENV['SERPAPI_KEY']

query = 'recursion'
url = URI("https://serpapi.com/search?q=#{URI.encode(query)}&api_key=#{api_key}")

response = Net::HTTP.get(url)
result = JSON.parse(response)

spelling_fix = result.dig('search_information', 'spelling_fix')

puts "Did you mean: #{spelling_fix}" if spelling_fix