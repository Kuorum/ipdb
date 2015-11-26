require 'mechanize'
require 'date'
require 'time'
require 'json'


region_abbreviation = 'EU-ES' #Unites States

task :scraper_EU_ES => [:environment] do

	agent = Mechanize.new

	puts "Scrapping BEGINS... #{Time.now}"

	page = agent.get("http://quehacenlosdiputados.net/diputados")
	page_links = page.links_with(href: %r{.*/diputado/\w+})

	member_links = page_links
	
	members = member_links.map do |link|	
		member = link.click

		source = "http://quehacenlosdiputados.net" + link.href

		# Get name
		name = member.search('.nombre').text.strip

		picture = ""
		if agent.page.image_with(:src => /imagenesDipus/)
			picture = agent.page.image_with(:src => /imagenesDipus/).to_s()	
		end

		party_picture = ""
		if member.at("img.partido")
			party_picture = member.search("img.partido").attr('alt').text.strip	
		end
		politicalParty = party_picture.split.last

		leaning_index = 0.0
		parties = PoliticalParty.where(:name => politicalParty)
		parties.each do |p|
			leaning_index += p.leaning_index
		end	

		placeOfBirth = member.search("#infoDiputado li:nth-child(2) span").text.strip.split(":")[1]

		email = member.at("li.network a[href]").to_s
		email_url = ""
		match = /href\s*=\s*"([^"]*)"/.match(email)
		if match
			email_url = match[1]
		end
		email_url = email_url.split(":")[1] 

		lastActivity1Date = ""
		lastActivity2Date = ""
		lastActivity3Date = ""
		lastActivity1 = ""
		lastActivity2 = ""
		lastActivity3 = ""
		lastActivity1Action = "Participate"
		lastActivity2Action = "Participate"
		lastActivity3Action = "Participate"
		lastActivity1Outcome = ""
		lastActivity2Outcome = ""
		lastActivity3Outcome = ""
		lastActivity1Link = ""
		lastActivity2Link = ""
		lastActivity3Link = ""

		if member.search(".tituloInic")[0]
			lastActivity1 = member.search(".tituloInic")[0].text.strip
		end

		if member.search(".tituloInic")[1]
			lastActivity2 = member.search(".tituloInic")[1].text.strip
		end

		if member.search(".tituloInic")[2]
			lastActivity3 = member.search(".tituloInic")[2].text.strip
		end	

		if member.search(".exito")[0]
			lastActivity1Outcome = member.search(".exito")[0].text.strip.split.first
		end

		activity = ""
		activity_outcome = ""
		activity_link = ""

		activity_list = member.search(".iniciativa")
		activity_list.each do |activity|
		
			if member.search(".tituloInic")
				activity = member.search(".tituloInic")[0].text.strip
			end

			if member.search(".tituloInic+ span")
				activity_outcome = member.search(".exito").text.strip
			end	

			link = member.at('.enlaceExtIcon[href]').to_s
			match = /href\s*=\s*"([^"]*)"/.match(link)
			if match
				activity_link = match[1]
			end

		end	
		
		puts "#{activity_link}"

	end


	#puts JSON.pretty_generate(members)

	# Insert data to database
	#Datum.create!(members)

	puts "Scrapping ENDS... #{Time.now}"



end