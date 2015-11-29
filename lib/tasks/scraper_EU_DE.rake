require 'mechanize'
require 'date'
require 'time'
require 'json'


region_abbreviation = 'EU-DE' 

task :scraper_EU_DE => [:environment] do

	agent = Mechanize.new

	last_page_number = 14

	for pg_number in 0..last_page_number do

		puts "Scrapping BEGINS... #{Time.now}"
		puts "Scrapping page #{pg_number} ..."

		page = agent.get("http://www.abgeordnetenwatch.de/abgeordnete-1128-#{pg_number}.html#profile")

		page_links = page.links_with(href: %r{.*-778-\w+})
		member_links = page_links		
		members = member_links.map do |link|	

		  member = link.click

		  source = link.href
		  source = "http://www.abgeordnetenwatch.de/" + source

		  name = member.search(".profil_name").text.strip
		  name = name.split("(")[0]

		  picture = ""
		  if agent.page.image_with(:src => /big/)
			picture = agent.page.image_with(:src => /big/).to_s()	
		  end	

		  box1 = member.search('.box1 div').to_s.gsub('/t','').strip
		  box1 = box1.gsub('<div class="title_data">','|')
		  box1 = box1.gsub('</div>','|')

		  dateOfBirth = box1.split('|')[2].strip
		  constituency = box1.split('|')[10].strip
		  constituency = constituency.split('<i>')[0]

		  puts "#{constituency}"

		end

		#puts JSON.pretty_generate(members)


		# Insert data to database
		#Datum.create!(members)


		puts "Scrapping ENDS... #{Time.now}"
	
	end

end