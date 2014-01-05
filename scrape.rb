require 'rubygems'
require 'mechanize'

agent = Mechanize.new
#Load pages list to page 
page = agent.get('http://en.wikipedia.org/wiki/List_of_American_film_actresses')

#Lookup table
actress = {}

# test = {}
# test['Diahnne_Abbott'] 	= 'http://en.wikipedia.org/wiki/Diahnne_Abbott'
# test['Amy_Acker'] 	= 'http://en.wikipedia.org/wiki/Amy_Acker'
# test['Rachel_Boston'] 	= 'http://en.wikipedia.org/wiki/Rachel_Boston'
# test['Selena_Gomez'] 	= 'http://en.wikipedia.org/wiki/Selena_Gomez'
# test['Candice_Accola'] = 'http://en.wikipedia.org/wiki/Candice_Accola'

page.search('.column-width ul li a').each do |link|
	#Form lookup of Name and Wiki-Link
	actress[link['title']] = "http://en.wikipedia.org" + link['href']
end


def parse_find_twitter(actor_url, actor_name)
	#open and parse page
	bot = Mechanize.new
	out = bot.get(actor_url)
	if out.links_with(:href=> /^.+:\W+twitter.com\W[a-zA-Z0-9_\W]{1,15}$/)[0]
		# tmp = out.links_with(:href=> /^.+:\W+twitter.com/)[0]
	   return [actor_name, out.links_with(:href=> /^.+:\W+twitter.com\W[a-zA-Z0-9_\W]{1,15}$/)[0].href]
	else
		# tmp = actor
		return [actor_name]
	end
	# return tmp.href || actor
end

#open a file output.csv
target = File.open('output.csv', 'w')
count = 0
actress.keys.each do |n|
	puts 'Processing '+ count.to_s
	target.write("#{parse_find_twitter(actress[n], n)[0]} | #{parse_find_twitter(actress[n], n)[1]}\n")
	count = count + 1
end

#Close file
target.close()


