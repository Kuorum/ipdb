require 'mechanize'
require 'date'
require 'json'


task :scraper_bookings => [:environment] do

	agent = Mechanize.new

	last_page_number = 1

	offset = 1

	for pg_number in 1..last_page_number do

		puts "Scrapping..."

		puts Time.now

		#puts offset

		offset = (pg_number - 1) * 15

		page = agent.get("http://www.booking.com/searchresults.html?aid=355028&sid=e1c9e4c7a000518d8a3725b9bb6e5306&dcid=1&class_interval=1&region=1706&rows=15&offset=#{offset}")
		
		puts page


		page_links = page.links_with(href: %r{.*/hotel/\w+})

		member_links = page_links

		members = member_links.map do |link|		

		  member = link.click

		  # Get name
		  name = member.search('#hp_hotel_name').text
		    

		  {	
		    name: name.strip,
		  }

		end

		puts JSON.pretty_generate(members)

		puts Time.now

		#offset += 15

	end

end