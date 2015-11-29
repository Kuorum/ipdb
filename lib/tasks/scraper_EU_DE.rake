require 'mechanize'
require 'date'
require 'time'
require 'json'


region_abbreviation = 'EU-DE' 

task :scraper_EU_DE => [:environment] do

	agent = Mechanize.new

	last_page_number = 14

	for pg_number in 1..last_page_number do

		puts "Scrapping BEGINS... #{Time.now}"
		puts "Scrapping page #{pg_number} ..."

		page = agent.get("http://www.abgeordnetenwatch.de/abgeordnete-1128-#{pg_number}.html#profile")
		page_links = page.links_with(href: %r{.*/-778-/\w+})

		member_links = page_links
		
		members = member_links.map do |link|	

		  member = link.click

		  source = link.href

		  # Get name
		  name = member.search('title')
		  
		  puts name


		end

		#puts JSON.pretty_generate(members)


		# Insert data to database
		#Datum.create!(members)


		puts "Scrapping ENDS... #{Time.now}"
	
	end

end