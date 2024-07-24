require 'net/http'
require 'json'
require 'dotenv/load'

api_key = ENV['SERPAPI_KEY']

query = 'Imran Khan birthday'
url = URI("https://serpapi.com/search?q=#{URI.encode(query)}&api_key=#{api_key}")

response = Net::HTTP.get(url)
result = JSON.parse(response)

birthday = result.dig('knowledge_graph', 'born')

if birthday
  puts "Imran Khan's birthday is #{birthday}"
else
  puts 'Birthday not found in the search result'
end
