require 'dotenv/load'
require 'net/http'
require 'json'
require 'uri'

def fetch_serpapi_results(query, location)
  api_key = ENV['SERPAPI_KEY']

  url = URI("https://serpapi.com/search?q=#{URI.escape(query)}&location=#{URI.escape(location)}&api_key=#{api_key}")

  response = Net::HTTP.get_response(url)

  if response.is_a?(Net::HTTPSuccess)
    results = JSON.parse(response.body)['organic_results']
    urls = results.map { |result| result['link'] }
    return urls
  else
    puts "Error fetching results: #{response.code} - #{response.message}"
    return []
  end
end

query = 'serpapi'
locations = [
  'New York, NY',
  'Los Angeles, CA',
  'Chicago, IL',
  'Houston, TX',
  'Phoenix, AZ',
  'Philadelphia, PA',
  'San Antonio, TX',
  'San Diego, CA',
  'Dallas, TX',
  'Karachi, Sindh, Pakistan'
]

locations.each do |location|
  urls = fetch_serpapi_results(query, location)
  puts "Results for #{location}:"
  urls.each_with_index do |url, index|
    puts "#{index + 1}. #{url}"
  end
  puts 
  puts 
end
