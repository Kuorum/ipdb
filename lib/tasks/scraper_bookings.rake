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

		offset = (pg_number - 1) * 15

		page = agent.get("http://www.booking.com/searchresults.en-gb.html?label=gen173nr-17CAEoggJCAlhYSDNiBW5vcmVmaFCIAQGYAS64AQTIAQTYAQHoAQH4AQs&sid=e1c9e4c7a000518d8a3725b9bb6e5306&dcid=1&class_interval=1&csflt=%7B%7D&dest_id=2438&dest_type=region&gtt=50b8d5eac0b48db956c673ad1a841cf5&idf=1&label_click=undef&no_rooms=1&review_score_group=empty&room1=A%2CA&sb_price_type=total&score_min=0&si=ai%2Cco%2Cci%2Cre%2Cdi&src=index&ss=Greater%20Manchester&ssb=empty&rows=15&offset=#{offset}&track_sr_ajax_click=1")

		page_links = page.links_with search: '.url'


		hotels = page_links.map do |hotel|		

		  hotel = link.click

		  # Get name
		  name = hotel.search('#hp_hotel_name').text.strip

		  #address
		  address = hotel.search('#hp_address_subtitle').text.strip


		  {	
		    name: name,
		    address: address,

		  }

		end

		puts JSON.pretty_generate(members)

		puts Time.now

		#offset += 15

	end

end