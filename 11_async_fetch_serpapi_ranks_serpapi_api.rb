require 'dotenv/load'
require 'spreadsheet'
require 'net/http'
require 'json'
require 'uri'

book = Spreadsheet.open './serpapi-tracking.xls'

sheet = book.worksheet 'tracking'

ids = []

sheet.each_with_index do |row, index|
  next if index < 2
  break if index == 20

  keyword = row[0]
  location = row[1]

  api_key = ENV['SERPAPI_KEY']
  url = URI("https://serpapi.com/search?q=#{keyword}&location=#{location}&num=100&api_key=#{api_key}&async=true")

  puts "Fetching results for #{keyword} in #{location}... Async"

  response = Net::HTTP.get(url)
  result = JSON.parse(response)

  ids << result['search_metadata']['id']
end

puts "Ids: #{ids}"
puts

sleep 3

ids.each do |id|
  url = URI("https://serpapi.com/searches/#{id}?api_key=#{ENV['SERPAPI_KEY']}")

  response = Net::HTTP.get(url)
  result = JSON.parse(response)

  keyword = result['search_parameters']['q']
  location = result['search_parameters']['location_requested']

  position = result['organic_results'].detect { |result| result['link'].include?('https://serpapi.com') }

  puts "Position for #{keyword} in #{location}:"
  puts position ? "👉 #{position['position']}" : 'Not found'
  puts
end
