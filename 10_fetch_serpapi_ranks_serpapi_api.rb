require 'dotenv/load'
require 'spreadsheet'
require 'net/http'
require 'json'
require 'uri'

book = Spreadsheet.open './serpapi-tracking.xls'

sheet = book.worksheet 'tracking'

sheet.each_with_index do |row, index|
  next if index < 2
  break if index == 50

  keyword = row[0]
  location = row[1]

  api_key = ENV['SERPAPI_KEY']
  url = URI("https://serpapi.com/search?q=#{keyword}&location=#{location}&num=100&api_key=#{api_key}")

  response = Net::HTTP.get(url)
  result = JSON.parse(response)

  position = result['organic_results'].detect { |result| result['link'].include?('https://serpapi.com') }

  puts "Position for #{keyword} in #{location}:"
  puts position ? "👉 #{position['position']}" : 'Not found'
  puts
end
