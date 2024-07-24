require 'google_search_results' 
require 'dotenv/load'

api_key = ENV['SERPAPI_KEY']

params = {
  engine: "google",
  q: "Imran Khan birthday",
  api_key: api_key
}

search = GoogleSearch.new(params)
knowledge_graph = search.get_hash
birthday = knowledge_graph.dig(:knowledge_graph, :born)

if birthday
  puts "Imran Khan's birthday is #{birthday}"
else
  puts 'Birthday not found in the search result'
end
