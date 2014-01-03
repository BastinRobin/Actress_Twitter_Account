#Extract the list of actress and wiki links into list
#Save = {}
#Loop through each actres
  #visit each actor wikipage
    #if link=>[http://twitter.com]
       #Save[title] = link    
    #else
      #Save[title] = title
#save_to MySQl dump


require 'rubygems'
require 'mechanize'

agent = Mechanize.new
#Load pages list to page 
page = agent.get('http://en.wikipedia.org/wiki/List_of_American_film_actresses')
actress = {}
page.search('.column-width ul li a').each do |link|
	#Form lookup of Name and Wiki-Link
	actress[link['title']] = "http://en.wikipedia.org" + link['href']
end

#Function
# -Parse page
# -Find twitterlink
# -return 
# Open file


def parse_find_twitter(actor)
	#open and parse page
	bot = Mechanize.new
	out = bot.get(actor)
	tmp = out.links_with(:href=> /^.+:\W+twitter.com/)[0]
	return tmp
end

target = File.open('output.csv', 'w')

actress.keys.each do |n|
	puts 'Processing'
	target.write(parse_find_twitter(actress[n]))
	target.write("\n")
end

target.close()


