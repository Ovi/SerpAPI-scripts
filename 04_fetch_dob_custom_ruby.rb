require 'mechanize'
require 'nokogiri'

query = 'Imran Khan birthday'
url = "https://www.google.com/search?q=#{URI.encode(query)}"

agent = Mechanize.new

agent.user_agent_alias = 'Windows Chrome'

page = agent.get(url)

parsed_content = Nokogiri::HTML(page.body)

birthday_element = parsed_content.at_css('[data-attrid="kc:/people/person:born"]')

if birthday_element
  birthday_text = birthday_element.text.strip
  birthday = birthday_text.split(':', 2).last.strip
  puts "Imran Khan's birthday is #{birthday}"
else
  puts 'Birthday not found in the search result'
end
