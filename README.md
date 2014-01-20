Actress_Twitter_Account
=======================

A Ruby scraper which scraps List of Hollywood Actress and their Twitter Account URLs


Algorithms:
=========

* Make a Dictionary of Actress from the hompage { name: url }.
```html
page = agent.get('http://en.wikipedia.org/wiki/List_of_American_film_actresses')
actress = {}

page.search('.column-width ul li a').each do |link|
        #Form lookup of Name and Wiki-Link
        actress[link['title']] = "http://en.wikipedia.org" + link['href']
end
```

* Iterate over the Actress Dictionary
  * Visit each actress from Actress Dict Using Parse_find_twitter function
```html
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
```

* Write the output to Output.txt file
