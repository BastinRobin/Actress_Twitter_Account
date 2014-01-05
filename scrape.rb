require 'rubygems'
require 'mechanize'

agent = Mechanize.new
# Load pages list to page 
page = agent.get('http://en.wikipedia.org/wiki/List_of_American_film_actresses')

# Lookup table
actress = {}

page.search('.column-width ul li a').each do |link|
	#Form lookup of Name and Wiki-Link
	actress[link['title']] = "http://en.wikipedia.org" + link['href']
end

# Parse each actress page and get twitter url
def parse_find_twitter(actor_url, actor_name)
	#open and parse page
	bot = Mechanize.new
	out = bot.get(actor_url)
	if out.links_with(:href=> /^.+:\W+twitter.com\W[a-zA-Z0-9_\W]{1,15}$/)[0]
	   return [actor_name, out.links_with(:href=> /^.+:\W+twitter.com\W[a-zA-Z0-9_\W]{1,15}$/)[0].href]
	else
		return [actor_name]
	end
end

# open a file output.txt
target = File.open('output.txt', 'w')
count = 0
actress.keys.each do |n|
	puts 'Processed '+ n +' - ' + count.to_s
	target.write("#{parse_find_twitter(actress[n], n)[0]} | #{parse_find_twitter(actress[n], n)[1]}\n")
	count = count + 1
end

# Close file
target.close()


