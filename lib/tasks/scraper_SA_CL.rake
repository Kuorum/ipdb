require 'mechanize'
require 'date'
require 'time'
require 'json'

region_abbreviation = 'SA-CL' # Espana (Spain)

task :scraper_SA_CL => [:environment] do

	agent = Mechanize.new

	puts "Scrapping BEGINS... #{Time.now}"

	page = agent.get("https://www.camara.cl/camara/diputados.aspx")
	page_links = page.links_with(href: %r{.*?prmid=\w+})					

	member_links = page_links
	
	member_counter = 1
	members = member_links.map do |link|	

		member = link.click

		source = "https://www.camara.cl/camara/" + link.href

		name = member.search('#ficha h3').text.strip
		name = name.gsub('Diputado','').strip
		name = name.gsub('Diputada','').strip

		politicalParty = member.search('.summary+ .summary p').text.strip
		politicalParty = politicalParty.gsub('Partido','')

		picture = agent.page.image_with(:src => %r{.*?prmid=\w+}).to_s()

		leaning_index = 0.5

		dateOfBirth = ""
		
		if member.search('.birthDate p')
			temp_date = member.search('.birthDate p').text.strip
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
			
			temp_date = "#{day}/#{month_in_integer.to_s}/#{year}"
			dateOfBirth = "#{temp_date} 00:00"	
		end

		email = member.search('.email a').text.strip

		lastActivity1Date = ""
		lastActivity2Date = ""
		lastActivity3Date = ""
		lastActivity4Date = ""
		lastActivity5Date = ""
		lastActivity1 = ""
		lastActivity2 = ""
		lastActivity3 = ""
		lastActivity4 = ""
		lastActivity5 = ""
		lastActivity1Action = "Participate"
		lastActivity2Action = "Participate"
		lastActivity3Action = "Participate"
		lastActivity4Action = "Participate"
		lastActivity5Action = "Participate"
		lastActivity1Outcome = ""
		lastActivity2Outcome = ""
		lastActivity3Outcome = ""
		lastActivity4Outcome = ""
		lastActivity5Outcome = ""
		lastActivity1Link = ""
		lastActivity2Link = ""
		lastActivity3Link = ""
		lastActivity4Link = ""
		lastActivity5Link = ""

		#activity_tab_link = member.search('#ctl00_mainPlaceHolder_btnSala').text.strip

		activity_tab_link = ""
		activity_tab_anchor = member.at("#ctl00_mainPlaceHolder_btnSala").to_s
		match = /href\s*=\s*"([^"]*)"/.match(activity_tab_anchor)
		if match
			activity_tab_link = match[1]
		end

		# Click the activity tab (Javascript)
		form = member.form("aspnetForm")
		form.add_field!('ctl00$mainPlaceHolder$btnSala','')
		tab = agent.submit(form)

		if tab.search('tr:nth-child(1) td:nth-child(1)')
			temp_date = tab.search('tr:nth-child(1) td:nth-child(1)').text.strip
			temp_date = temp_date.gsub("de", "")
			day = temp_date.split.first
			month = temp_date.split.second
			month = month.gsub(".", "")
			month_in_integer = 0
			if month == "Ene" 
				month_in_integer = 1 
			elsif month  == "Feb"
				month_in_integer = 2
			elsif month  == "Mar"	
				month_in_integer = 3
			elsif month  ==	"Abr"
				month_in_integer = 4
			elsif month  ==	"May"
				month_in_integer = 5
			elsif month  ==	"Jun"
				month_in_integer = 6
			elsif month  ==	"Jul"
				month_in_integer = 7
			elsif month  ==	"Ago"
				month_in_integer = 8
			elsif month  ==	"Sep"
				month_in_integer = 9
			elsif month  ==	"Oct"
				month_in_integer = 10
			elsif month  ==	"Nov"
				month_in_integer = 11
			elsif month  ==	"Dic"
				month_in_integer = 12			
			end	
			year = temp_date.split.last
			
			temp_date = "#{day}/#{month_in_integer.to_s}/#{year}"
			lastActivity1Date = "#{temp_date} 00:00"	
		end

		if tab.search('tr:nth-child(2) td:nth-child(1)').text.strip
			temp_date = tab.search('tr:nth-child(2) td:nth-child(1)').text.strip
			temp_date = temp_date.gsub("de", "")
			day = temp_date.split.first
			month = temp_date.split.second
			month = month.gsub(".", "")
			month_in_integer = 0
			if month == "Ene" 
				month_in_integer = 1 
			elsif month  == "Feb"
				month_in_integer = 2
			elsif month  == "Mar"	
				month_in_integer = 3
			elsif month  ==	"Abr"
				month_in_integer = 4
			elsif month  ==	"May"
				month_in_integer = 5
			elsif month  ==	"Jun"
				month_in_integer = 6
			elsif month  ==	"Jul"
				month_in_integer = 7
			elsif month  ==	"Ago"
				month_in_integer = 8
			elsif month  ==	"Sep"
				month_in_integer = 9
			elsif month  ==	"Oct"
				month_in_integer = 10
			elsif month  ==	"Nov"
				month_in_integer = 11
			elsif month  ==	"Dic"
				month_in_integer = 12			
			end	
			year = temp_date.split.last
			
			temp_date = "#{day}/#{month_in_integer.to_s}/#{year}"
			lastActivity2Date = "#{temp_date} 00:00"	
		end

		if tab.search('tr:nth-child(3) td:nth-child(1)').text.strip
			temp_date = tab.search('tr:nth-child(3) td:nth-child(1)').text.strip
			temp_date = temp_date.gsub("de", "")
			day = temp_date.split.first
			month = temp_date.split.second
			month = month.gsub(".", "")
			month_in_integer = 0
			if month == "Ene" 
				month_in_integer = 1 
			elsif month  == "Feb"
				month_in_integer = 2
			elsif month  == "Mar"	
				month_in_integer = 3
			elsif month  ==	"Abr"
				month_in_integer = 4
			elsif month  ==	"May"
				month_in_integer = 5
			elsif month  ==	"Jun"
				month_in_integer = 6
			elsif month  ==	"Jul"
				month_in_integer = 7
			elsif month  ==	"Ago"
				month_in_integer = 8
			elsif month  ==	"Sep"
				month_in_integer = 9
			elsif month  ==	"Oct"
				month_in_integer = 10
			elsif month  ==	"Nov"
				month_in_integer = 11
			elsif month  ==	"Dic"
				month_in_integer = 12			
			end	
			year = temp_date.split.last
			
			temp_date = "#{day}/#{month_in_integer.to_s}/#{year}"
			lastActivity3Date = "#{temp_date} 00:00"	
		end
		
		if tab.search('tr:nth-child(4) td:nth-child(1)').text.strip
			temp_date = tab.search('tr:nth-child(4) td:nth-child(1)').text.strip
			temp_date = temp_date.gsub("de", "")
			day = temp_date.split.first
			month = temp_date.split.second
			month = month.gsub(".", "")
			month_in_integer = 0
			if month == "Ene" 
				month_in_integer = 1 
			elsif month  == "Feb"
				month_in_integer = 2
			elsif month  == "Mar"	
				month_in_integer = 3
			elsif month  ==	"Abr"
				month_in_integer = 4
			elsif month  ==	"May"
				month_in_integer = 5
			elsif month  ==	"Jun"
				month_in_integer = 6
			elsif month  ==	"Jul"
				month_in_integer = 7
			elsif month  ==	"Ago"
				month_in_integer = 8
			elsif month  ==	"Sep"
				month_in_integer = 9
			elsif month  ==	"Oct"
				month_in_integer = 10
			elsif month  ==	"Nov"
				month_in_integer = 11
			elsif month  ==	"Dic"
				month_in_integer = 12			
			end	
			year = temp_date.split.last
			
			temp_date = "#{day}/#{month_in_integer.to_s}/#{year}"
			lastActivity4Date = "#{temp_date} 00:00"	
		end
		
		if tab.search('tr:nth-child(5) td:nth-child(1)').text.strip
			temp_date = tab.search('tr:nth-child(5) td:nth-child(1)').text.strip
			temp_date = temp_date.gsub("de", "")
			day = temp_date.split.first
			month = temp_date.split.second
			month = month.gsub(".", "")
			month_in_integer = 0
			if month == "Ene" 
				month_in_integer = 1 
			elsif month  == "Feb"
				month_in_integer = 2
			elsif month  == "Mar"	
				month_in_integer = 3
			elsif month  ==	"Abr"
				month_in_integer = 4
			elsif month  ==	"May"
				month_in_integer = 5
			elsif month  ==	"Jun"
				month_in_integer = 6
			elsif month  ==	"Jul"
				month_in_integer = 7
			elsif month  ==	"Ago"
				month_in_integer = 8
			elsif month  ==	"Sep"
				month_in_integer = 9
			elsif month  ==	"Oct"
				month_in_integer = 10
			elsif month  ==	"Nov"
				month_in_integer = 11
			elsif month  ==	"Dic"
				month_in_integer = 12			
			end	
			year = temp_date.split.last
			
			temp_date = "#{day}/#{month_in_integer.to_s}/#{year}"
			lastActivity5Date = "#{temp_date} 00:00"	
		end
		
		lastActivity1 = tab.search('tr:nth-child(1) td:nth-child(3)').text.strip
		lastActivity2 = tab.search('tr:nth-child(2) td:nth-child(3)').text.strip
		lastActivity3 = tab.search('tr:nth-child(3) td:nth-child(3)').text.strip
		lastActivity4 = tab.search('tr:nth-child(4) td:nth-child(3)').text.strip
		lastActivity5 = tab.search('tr:nth-child(5) td:nth-child(3)').text.strip

		lastActivity1Outcome = tab.search('tr:nth-child(1) td:nth-child(4)').text.strip
		lastActivity2Outcome = tab.search('tr:nth-child(2) td:nth-child(4)').text.strip
		lastActivity3Outcome = tab.search('tr:nth-child(3) td:nth-child(4)').text.strip
		lastActivity4Outcome = tab.search('tr:nth-child(4) td:nth-child(4)').text.strip
		lastActivity5Outcome = tab.search('tr:nth-child(5) td:nth-child(4)').text.strip

		lastActivity1Link = tab.at('tr:nth-child(1) .pdf a').to_s
		match = /href\s*=\s*"([^"]*)"/.match(lastActivity1Link)
		if match
			lastActivity1Link = match[1]
			lastActivity1Link = lastActivity1Link.gsub('..','')
			lastActivity1Link = "https://www.camara.cl#{lastActivity1Link}"
		end

		lastActivity2Link = tab.at('tr:nth-child(2) .pdf a').to_s
		match = /href\s*=\s*"([^"]*)"/.match(lastActivity2Link)
		if match
			lastActivity2Link = match[1]
			lastActivity2Link = lastActivity2Link.gsub('..','')
			lastActivity2Link = "https://www.camara.cl#{lastActivity2Link}"
		end

		lastActivity3Link = tab.at('tr:nth-child(3) .pdf a').to_s
		match = /href\s*=\s*"([^"]*)"/.match(lastActivity3Link)
		if match
			lastActivity3Link = match[1]
			lastActivity3Link = lastActivity3Link.gsub('..','')
			lastActivity3Link = "https://www.camara.cl#{lastActivity3Link}"
		end

		lastActivity4Link = tab.at('tr:nth-child(4) .pdf a').to_s
		match = /href\s*=\s*"([^"]*)"/.match(lastActivity4Link)
		if match
			lastActivity4Link = match[1]
			lastActivity4Link = lastActivity4Link.gsub('..','')
			lastActivity4Link = "https://www.camara.cl#{lastActivity4Link}"
		end

		lastActivity5Link = tab.at('tr:nth-child(5) .pdf a').to_s
		match = /href\s*=\s*"([^"]*)"/.match(lastActivity5Link)
		if match
			lastActivity5Link = match[1]
			lastActivity5Link = lastActivity5Link.gsub('..','')
			lastActivity5Link = "https://www.camara.cl#{lastActivity5Link}"
		end

		profession = member.search('.profession p').text.strip 
		
		phone = member.search('.phones p').text.strip
		phone = phone.gsub('Teléfono:','')
		phone = phone.gsub(/[[:space:]]+/, "")

		#puts "#{phone}"

		# SET REGION ID 
		region_id = 422

		# GET REGION NAME & CODES
		region = "chile"
		region_code_alliance = "SA"
		region_code_nation = "CL"
		region_code_state = ""
		region_code_county = ""
		region_code_city = ""

		constituency = ""
		constituency_code_alliance = "SA"
		constituency_code_nation = "CL"
		constituency_code_state = ""
		constituency_code_county = ""
		constituency_code_city = ""

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
			lastActivity4:lastActivity4,
			lastActivity5:lastActivity5,
			lastActivity1Action:lastActivity1Action,
			lastActivity2Action:lastActivity2Action,
			lastActivity3Action:lastActivity3Action,
			lastActivity4Action:lastActivity4Action,
			lastActivity5Action:lastActivity5Action,
			lastActivity1Outcome:lastActivity1Outcome,
			lastActivity2Outcome:lastActivity2Outcome,
			lastActivity3Outcome:lastActivity3Outcome,
			lastActivity4Outcome:lastActivity4Outcome,
			lastActivity5Outcome:lastActivity5Outcome,
			lastActivity1Link:lastActivity1Link,
			lastActivity2Link:lastActivity2Link,
			lastActivity3Link:lastActivity3Link,
			lastActivity4Link:lastActivity4Link,
			lastActivity5Link:lastActivity5Link,
			dateOfBirth: dateOfBirth,
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
		}


	end

	puts JSON.pretty_generate(members)

	# Insert data to database
	Datum.create!(members)

	puts "Scrapping ENDS... #{Time.now}"



end