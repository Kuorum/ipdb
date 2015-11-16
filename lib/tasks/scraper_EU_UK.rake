require 'mechanize'
require 'date'
require 'time'
require 'json'


region_abbreviation = 'EU-UK' #United Kingdom

task :scraper_EU_UK => [:environment] do

	agent = Mechanize.new

	last_page_number = 1

	for pg_number in 1..last_page_number do

		puts "Scrapping BEGINS... #{Time.now}"
		puts "Scrapping page #{pg_number} ..."

		page = agent.get("http://www.theyworkforyou.com/peers/")
		page_links = page.links_with(href: %r{.*/mp/\w+})

		member_links = page_links
		
		members = member_links.map do |link|		

		  member = link.click

		  source = link.href

		  name = member.search('.mp-name-and-position h1').text

		  if agent.page.image_with(:src => /mps/)
		  	picture = agent.page.image_with(:src => /mps/).to_s()	
		  end

		  politicalParty = member.search('.party').text.strip 
		 
		  # Data from Wiki
		  if member.link_with(:text => /Wikipedia/)
			  wiki = member.link_with(:text => /Wikipedia/).click
			  birthday = wiki.search('.bday').text.strip
		  end

		  # Political Activities
		  activities = [];

		  title = ""
		  
		  #search_link = member.link_with search: '.appearances a'
		  #search_link = member.search('.appearances a[href]').to_s
		  search_link = member.links_with search: '.appearances+ p a'

		  #url1 = ""
		  #match = /href\s*=\s*"([^"]*)"/.match(search_link)
		  #if match
			#url1 = match[1]
		  #end

		  #puts "LINK IS: #{search_link.size}"	

		  ap = search_link[0].click
		  #pages = activity_page.map  do |page| 
		  	  #ap = page.click	

		  	  #title = ap.search('title').text.strip

		  	  #puts "TITLE IS #{title}"

			  activity_list = ap.search('.search-result--generic')
			  #puts "TOTAL NO OF ACTIVITIES: #{activity_list.size} " 

			  activity_list.each do |list| 

			  	# ACTIVITY DATE
			  	#activity_date = link.search('.date').text.strip
			  	activity_date = list.search('.search-result__title').text.strip
			  	date = activity_date.scan(/\w+/).values_at(-1, -2, -3)
			  	activity_date = "#{date[2]}/#{date[1]}/#{date[0]}" 
			  	activity_date = activity_date.to_time.strftime('%d/%m/%Y 00:00')
			  	#activity_date = activity_date

			  	# ACTIVITY NAME
			  	activity_name = list.search('.search-result__title a').text.strip
			  	#puts "ACTIVITY IS: #{activity_name}" 
			  	#puts list

			  	# ACTIVITY LINK
				activity_link = list.at('.search-result__title a[href]').to_s
				activity_url = ""
				match = /href\s*=\s*"([^"]*)"/.match(activity_link)
				if match
					activity_url = match[1]
				end

				# FINAL ACTIVITY
			  	activity = activity_date + "|" + activity_name + "|" + activity_url

			  	#if (activity_date != "") && (activity_name != "") && (activity_link != "")  
			  	#	activities.push(activity)
			  	#end 
			  	puts "ACTIVITY is: #{activity}"


			  
			  end	
		  #end

		  lastActivity1Date = ""
		  lastActivity2Date = ""
		  lastActivity3Date = ""
		  lastActivity1 = ""
		  lastActivity2 = ""
		  lastActivity3 = ""
		  lastActivity1Link = ""
		  lastActivity2Link = ""
		  lastActivity3Link = ""

		  counter = 1
		  activities.each do |activity|
		  	
		  	if counter == 1
			  	lastActivity1Date = activity.split('|')[0]
			  	lastActivity1 = activity.split('|')[1]
			  	lastActivity1Link = activity.split('|')[2]
		  	elsif counter == 2
		  		lastActivity2Date = activity.split('|')[0]
		  		lastActivity2 = activity.split('|')[1]
		  		lastActivity2Link = activity.split('|')[2]
		  	elsif counter == 3
		 		lastActivity3Date = activity.split('|')[0]
		 		lastActivity3 = activity.split('|')[1]
		    	lastActivity3Link = activity.split('|')[2]
		   	end	

		   	counter += 1
		  end  


		  if (lastActivity1Date != "") 
		  	converted_ldate1 = lastActivity1Date.to_time.strftime('%d/%m/%Y 00:00')
		  else
		    converted_ldate1 = lastActivity1Date
		  end

		  if (lastActivity2Date != "") 
		  	converted_ldate2 = lastActivity2Date.to_time.strftime('%d/%m/%Y 00:00')
		  else
		    converted_ldate2 = lastActivity2Date
		  end

		  if (lastActivity3Date != "") 
		  	converted_ldate3 = lastActivity3Date.to_time.strftime('%d/%m/%Y 00:00')
		  else
		    converted_ldate3 = lastActivity3Date
		  end


		  url1 = ""
		  url2 = ""
		  url3 = ""
		  url4 = ""
		  url5 = ""

		  match = /href\s*=\s*"([^"]*)"/.match(lastActivity1Link)
		  if match
			url1 = match[1]
		  end

		  match = /href\s*=\s*"([^"]*)"/.match(lastActivity2Link)
		  if match
			url2 = match[1]
		  end

		  match = /href\s*=\s*"([^"]*)"/.match(lastActivity3Link)
		  if match
			url3 = match[1]
		  end


		  #puts "#{name} | #{birthday} | #{picture} | #{politicalParty} | #{lastActivity1Date} | #{lastActivity1} | #{url1} | #{title} "


		  # GENERATE JSON
		  {

		  }

		end

		#puts JSON.pretty_generate(members)


		# Insert data to database
		#Datum.create!(members)


		# Set country as scraped
		#country = Country.find_by_region(region_id)
		#country.scraped = true
		#country.save


		puts "Scrapping ENDS... #{Time.now}"
		#puts "Total number of records being scraped: #{count}"

	end

end