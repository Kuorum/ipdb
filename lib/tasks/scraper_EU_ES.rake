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
	
	member_counter = 1
	members = member_links.map do |link|	
		puts member_counter

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

		temp_date = member.search("#infoDiputado li:nth-child(1) span").text.strip.split(":")[1]
		temp_date = temp_date.split("(")[0]
		temp_date = temp_date.gsub("de", "")
		day = temp_date.split.first
		month = temp_date.split.second
		month_in_integer = 0
		if month == "enero" 
			month_in_integer = 1 
		elsif month  == "febrero"
			month_in_integer = 2
		elsif month  == "marzo"	
			month_in_integer = 3
		elsif month  ==	"abril"
			month_in_integer = 4
		elsif month  ==	"mayo"
			month_in_integer = 5
		elsif month  ==	"junio"
			month_in_integer = 6
		elsif month  ==	"julio"
			month_in_integer = 7
		elsif month  ==	"agosto"
			month_in_integer = 8
		elsif month  ==	"septiembre"
			month_in_integer = 9
		elsif month  ==	"octubre"
			month_in_integer = 10
		elsif month  ==	"noviembre"
			month_in_integer = 11
		elsif month  ==	"diciembre"
			month_in_integer = 12			
		end	
		year = temp_date.split.last
		temp_date = day + "/" + month_in_integer.to_s + "/" + year
		dateOfBirth = temp_date.to_time.strftime('%d/%m/%Y 00:00') 

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

		activity_name = ""
		activity_outcome = ""
		activity_link = ""
		activity_date = ""

		activities = []
		activity_list = member.search(".iniciativa")

		counter = 1
		activity_list.each do |activity|
		
			if activity.search(".tituloInic+ span")
				temp_date = activity.search(".tituloInic+ span").text.strip
				temp_date = temp_date.split(",")[1]
				temp_date = temp_date.gsub("calificada el", "")
				temp_date = temp_date.gsub("de", "")

				day = temp_date.split.first
				month = temp_date.split.second
				month_in_integer = 0
				if month == "enero" 
					month_in_integer = 1 
				elsif month  == "febrero"
					month_in_integer = 2
				elsif month  == "marzo"	
					month_in_integer = 3
				elsif month  ==	"abril"
					month_in_integer = 4
				elsif month  ==	"mayo"
					month_in_integer = 5
				elsif month  ==	"junio"
					month_in_integer = 6
				elsif month  ==	"julio"
					month_in_integer = 7
				elsif month  ==	"agosto"
					month_in_integer = 8
				elsif month  ==	"septiembre"
					month_in_integer = 9
				elsif month  ==	"octubre"
					month_in_integer = 10
				elsif month  ==	"noviembre"
					month_in_integer = 11
				elsif month  ==	"diciembre"
					month_in_integer = 12			
				end	

				year = temp_date.split.last

				temp_date = day + "/" + month_in_integer.to_s + "/" + year

				activity_date = temp_date.to_time.strftime('%d/%m/%Y 00:00') 

				#puts "activity date is: #{activity_date}"
			end	

			if activity.search(".tituloInic")
				activity_name = activity.search(".tituloInic").text.strip
			end

			if activity.search(".fa-thumbs-up")
				activity_outcome = "Tramitado"
			elsif activity.search(".fa-clock-o")
				activity_outcome = "En tramitación"
			end	

			link = activity.at('.enlaceExtIcon[href]').to_s
			match = /href\s*=\s*"([^"]*)"/.match(link)
			if match
				activity_link = match[1]
			end

			
			if counter == 1 
			  	lastActivity1Date = activity_date
			  	lastActivity1 = activity_name
			  	lastActivity1Outcome = activity_name
			  	lastActivity1Link = activity_link
			elsif counter == 2
				lastActivity2Date = activity_date
			  	lastActivity2 = activity_name
			  	lastActivity2Outcome = activity_name
			  	lastActivity2Link = activity_link
			elsif counter == 3
				lastActivity3Date = activity_date
			  	lastActivity3 = activity_name
			  	lastActivity3Outcome = activity_name
			  	lastActivity3Link = activity_link
			end 	

			counter += 1
		end	
		
		# FINAL ACTIVITY
	  	#activity1 = lastActivity1Date + "|" + lastActivity1 + "|" + lastActivity1Outcome + "|" + lastActivity1Link
	  	#activity2 = lastActivity2Date + "|" + lastActivity2 + "|" + lastActivity2Outcome + "|" + lastActivity2Link
	  	#activity3 = lastActivity3Date + "|" + lastActivity3 + "|" + lastActivity3Outcome + "|" + lastActivity3Link
	  	#puts "Activity 1 is #{activity1}"
	  	#puts "Activity 2 is #{activity2}"
	  	#puts "Activity 3 is #{activity3}"
	  	#activities.push(activity)

	  	# SET REGION ID 
		region_id = 2

		# GET REGION NAME & CODES
		region = "espana"
		region_code_alliance = "EU"
		region_code_nation = "ES"
		region_code_state = ""
		region_code_county = ""
		region_code_city = ""

		# GET CONSTITUENCY NAME & CODES
		state_code = ""
		state_name = ""
		temp_state_name = member.search(".circunscripcion a").text.strip
		if temp_state_name == "A Coruña"
			state_name = "a coruna"
		elsif temp_state_name == "Almería"
			state_name = "almeria" 
		elsif temp_state_name == "Araba/Álava"
			state_name = "araba" 
		elsif temp_state_name == "Álava"
			state_name = "araba" 
		elsif temp_state_name == "Ávila"
			state_name = "avila" 
		elsif temp_state_name == "Cáceres"
			state_name = "caceres" 
		elsif temp_state_name == "Cádiz"
			state_name = "cadiz" 
		elsif temp_state_name == "Córdoba"
			state_name = "cordoba" 
		elsif temp_state_name == "Jaén"
			state_name = "jaen" 
		elsif temp_state_name == "León"
			state_name = "leon"
		elsif temp_state_name == "Málaga"
			state_name = "malaga"
		elsif temp_state_name == "Gipuzkoa" 
			state_name = "guipuzkoa" 
		elsif temp_state_name == "Illes Balears"
			state_name = "islas baleares"  	
		else
			state_name = temp_state_name				 						 	 									
		end	

		regions = Region.all 
		regions.each do |region|
			if (region.name.downcase == state_name.downcase) 
				state_code = region.iso3166_2
			end
		end	

		constituency = state_name.downcase.gsub(/\s/, '_')
		constituency_code_alliance = "EU"
		constituency_code_nation = "ES"
		constituency_code_state = state_code.split('-')[2]
		constituency_code_county = ""
		constituency_code_city = ""


		electoralAddress = constituency
		institution = "Congreso de los Diputados"

		member_counter += 1

		# GENERATE JSON
		{
			sourceWebsite: source,	
			name: name,
			picture: picture,
			politicalParty: politicalParty,
			political_leaning_index: leaning_index,
			ideology1: leaning_index,
			ideology2: leaning_index,
			ideology3: leaning_index,
			ideology4: leaning_index,
			ideology5: leaning_index,
			lastActivity1Date:lastActivity1Date,
			lastActivity2Date:lastActivity2Date,
			lastActivity3Date:lastActivity3Date,
			lastActivity1:lastActivity1,
			lastActivity2:lastActivity2,
			lastActivity3:lastActivity3,
			lastActivity1Action:lastActivity1Action,
			lastActivity2Action:lastActivity2Action,
			lastActivity3Action:lastActivity3Action,
			lastActivity1Outcome:lastActivity1Outcome,
			lastActivity2Outcome:lastActivity2Outcome,
			lastActivity3Outcome:lastActivity3Outcome,
			lastActivity1Link:lastActivity1Link,
			lastActivity2Link:lastActivity2Link,
			lastActivity3Link:lastActivity3Link,
			dateOfBirth: dateOfBirth,
			placeOfBirth: placeOfBirth,
			electoralAddress: electoralAddress,
			region_id: region_id,
			region:region,
			region_code_alliance:region_code_alliance,
			region_code_nation:region_code_nation,
			region_code_state:region_code_state,
			region_code_county:region_code_county,
			region_code_city:region_code_city,
			constituency:constituency,
			constituency_code_alliance:constituency_code_alliance,
			constituency_code_nation:constituency_code_nation,
			constituency_code_state:constituency_code_state,
			constituency_code_county:constituency_code_county,
			constituency_code_city:constituency_code_city,
			institution: institution
		}

	end

	puts JSON.pretty_generate(members)

	# Insert data to database
	#Datum.create!(members)

	puts "Scrapping ENDS... #{Time.now}"



end