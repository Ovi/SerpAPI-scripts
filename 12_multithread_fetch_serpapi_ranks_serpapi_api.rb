require 'dotenv/load'
require 'spreadsheet'
require 'net/http'
require 'json'
require 'uri'

book = Spreadsheet.open './serpapi-tracking.xls'
sheet = book.worksheet 'tracking'

api_key = ENV['SERPAPI_KEY']
base_url = "https://serpapi.com/search?num=100&api_key=#{api_key}"

def fetch_position(keyword, location, base_url)
  url = URI("#{base_url}&q=#{URI.encode(keyword)}&location=#{URI.encode(location)}")
  response = Net::HTTP.get(url)
  result = JSON.parse(response)

  position = result['organic_results'].detect { |result| result['link'].include?('https://serpapi.com') }
  position ? "👉 #{position['position']}" : 'Not found'
rescue => e
  "Error: #{e.message}"
end

threads = []

sheet.each_with_index do |row, index|
  next if index < 2
  break if index == 50

  keyword = row[0]
  location = row[1]

  threads << Thread.new do
    result = fetch_position(keyword, location, base_url)
    puts "Position for #{keyword} in #{location}:"
    puts result
    puts
  end
end

# threads.each do |thread|
#   thread.join
# end
threads.each(&:join)
