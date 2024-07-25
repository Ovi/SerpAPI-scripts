require 'dotenv/load'
require 'net/http'
require 'json'
require 'uri'

def fetch_serpapi_results(engine, query)
  api_key = ENV['SERPAPI_KEY']
  queryParam = "q=#{URI.escape(query)}"
  queryParam = "p=#{URI.escape(query)}" if engine == "yahoo"

  url = URI("https://serpapi.com/search?engine=#{engine}&#{queryParam}&api_key=#{api_key}")

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
engines = [
  'google',
  'baidu',
  'bing',
  'yahoo'
]

engines.each do |engine|
  urls = fetch_serpapi_results(engine, query)
  puts "Results for #{engine}:"
  urls.each_with_index do |url, index|
    puts "#{index + 1}. #{url}"
  end
  puts
  puts
end
