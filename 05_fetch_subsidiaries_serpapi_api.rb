require 'net/http'
require 'json'
require 'dotenv/load'

api_key = ENV['SERPAPI_KEY']

query = 'google subsidiaries'
url = URI("https://serpapi.com/search?q=#{URI.encode(query)}&api_key=#{api_key}")

response = Net::HTTP.get(url)
result = JSON.parse(response)

subsidiaries = result.dig('knowledge_graph', 'subsidiaries')

if subsidiaries
  subsidiaries.each do |subsidiary|
    p subsidiary['name']
  end
else
  puts 'Subsidiaries not found in the search result'
end
