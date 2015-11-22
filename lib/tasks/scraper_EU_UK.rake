require 'mechanize'
require 'date'
require 'time'
require 'json'


region_abbreviation = 'EU-UK' #United Kingdom

task :scraper_EU_UK => [:environment] do


	agent = Mechanize.new


	url1 = "http://www.theyworkforyou.com/peers/"
	url2 = "http://www.theyworkforyou.com/mps/"

	puts "Scrapping Part 1.."
	puts "#{Time.now}"
	page = agent.get(url1)
	page_links = page.links_with(href: %r{.*/mp/\w+})
	member_links = page_links
	members = member_links.map do |link|		

		member = link.click

		source = "http://www.theyworkforyou.com" + link.href

		name = member.search('.mp-name-and-position h1').text

		puts name

		picture = ""

		if agent.page.image_with(:src => /mps/)
			picture = agent.page.image_with(:src => /mps/).to_s()	
		end

		politicalParty = member.search('.party').text.strip 

		leaning_index = 0.5

		dateOfBirth = ""
		bio = ""

		# Data from Wiki
		if member.link_with(:text => /Wikipedia/)
		  wiki = member.link_with(:text => /Wikipedia/).click
		  dateOfBirth = wiki.search('.bday').text.strip
		  
		 
		  if dateOfBirth != ""
		  	dateOfBirth = dateOfBirth[0..9].to_time.strftime('%d/%m/%Y 00:00')
		  end	

		  bio = wiki.search('.vcard+ p').text.strip
		  if bio == ""
		  	bio = wiki.search('.mbox-small+ p').text.strip
		  end	

		end


		officialWebsite = ""

		# ACTIVITY LINK
		if member.link_with(:text => /Personal website/)
			officialWebsite = member.link_with(:text => /Personal website/).href
		end	
		
		electoralAddress = ""

		# SET REGION ID (refer data table in db)
		region_id = 72

		# GET REGION NAME & CODES
		region_name = "united_kingdom"
		region = "EU-UK"
		region_code_alliance = "EU"
		region_code_nation = "UK"
		region_code_state = ""
		region_code_county = ""
		region_code_city = ""

		constituency_name = ""
		constituency = ""
		constituency_code_alliance = "EU"
		constituency_code_nation = "UK"
		constituency_code_state = ""
		constituency_code_county = ""
		constituency_code_city = ""

		institution = ""

		# Political Activities
		activities = [];

		title = ""
		  
		search_link = member.links_with search: '.appearances+ p a'

		if search_link[0]
			ap = search_link[0].click

			activity_list = ap.search('.search-result--generic')
			
			activity_list.each do |list| 
			 	# ACTIVITY DATE
			  	activity_date = list.search('.search-result__title').text.strip
			  	date = activity_date.scan(/\w+/).values_at(-1, -2, -3)
			  	activity_date = "#{date[2]}/#{date[1]}/#{date[0]}" 
			  	activity_date = activity_date.to_time.strftime('%d/%m/%Y 00:00')
			
			  	# ACTIVITY NAME
			  	activity_name = list.search('.search-result__title a').text.strip
			
			  	# ACTIVITY LINK
				activity_link = list.at('.search-result__title a[href]').to_s
				activity_url = ""
				match = /href\s*=\s*"([^"]*)"/.match(activity_link)
				if match
					activity_url = match[1]
				end

				if activity_url != ""
					activity_url = "http://www.theyworkforyou.com" + activity_url   
				end	

				# FINAL ACTIVITY
			  	activity = activity_date + "|" + activity_name + "|" + activity_url
			  	activities.push(activity)
			  	#puts "ACTIVITY is: #{activity}"		  
			  end	
		  	end
		 

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
		lastActivity1Action = ""
		lastActivity2Action = ""
		lastActivity3Action = ""
		lastActivity4Action = ""
		lastActivity5Action = ""
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
		    elsif counter == 4
		 		lastActivity4Date = activity.split('|')[0]
		 		lastActivity4 = activity.split('|')[1]
		    	lastActivity4Link = activity.split('|')[2]
		    elsif counter == 5
		 		lastActivity5Date = activity.split('|')[0]
		 		lastActivity5 = activity.split('|')[1]
		    	lastActivity5Link = activity.split('|')[2]		
		   	end	

		   	counter += 1
		end  

		#puts "#{name} | #{birthday} | #{picture} | #{politicalParty} | #{lastActivity5Date} | #{lastActivity5} | #{lastActivity5Link}  "

		# GENERATE JSON
		{
			sourceWebsite: source,	
			name: name.strip,
			picture: picture,
			politicalParty: politicalParty,
			political_leaning_index: leaning_index,
			ideology1: leaning_index,
			ideology2: leaning_index,
			ideology3: leaning_index,
			ideology4: leaning_index,
			ideology5: leaning_index,
			bio: bio,
			lastActivity1Date:lastActivity1Date,
			lastActivity2Date:lastActivity2Date,
			lastActivity3Date:lastActivity3Date,
			lastActivity4Date:lastActivity4Date,
			lastActivity5Date:lastActivity5Date,
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
			electoralAddress: electoralAddress,
			region_id: region_id,
			region:region_name,
			region_code_alliance:region_code_alliance,
			region_code_nation:region_code_nation,
			region_code_state:region_code_state,
			region_code_county:region_code_county,
			region_code_city:region_code_city,
			constituency:constituency_name,
			constituency_code_alliance:constituency_code_alliance,
			constituency_code_nation:constituency_code_nation,
			constituency_code_state:constituency_code_state,
			constituency_code_county:constituency_code_county,
			constituency_code_city:constituency_code_city,
			institution: institution,
			officialWebsite: officialWebsite
		}
	end
	#puts JSON.pretty_generate(members)
	Datum.create!(members)

	puts "Scrapping Part 2.."
	puts "#{Time.now}"
	page = agent.get(url2)
	page_links = page.links_with(href: %r{.*/mp/\w+})
	member_links = page_links
	members = member_links.map do |link|		

		member = link.click

		source = "http://www.theyworkforyou.com" + link.href

		name = member.search('.mp-name-and-position h1').text

		puts name

		picture = ""

		if agent.page.image_with(:src => /mps/)
			picture = agent.page.image_with(:src => /mps/).to_s()	
		end

		politicalParty = member.search('.party').text.strip 

		leaning_index = 0.5

		dateOfBirth = ""
		bio = ""

		# Data from Wiki
		if member.link_with(:text => /Wikipedia/)
		  wiki = member.link_with(:text => /Wikipedia/).click
		  dateOfBirth = wiki.search('.bday').text.strip
		  
		 
		  if dateOfBirth != ""
		  	dateOfBirth = dateOfBirth[0..9].to_time.strftime('%d/%m/%Y 00:00')
		  end	

		  bio = wiki.search('.vcard+ p').text.strip
		  if bio == ""
		  	bio = wiki.search('.mbox-small+ p').text.strip
		  end	

		end


		officialWebsite = ""

		# ACTIVITY LINK
		if member.link_with(:text => /Personal website/)
			officialWebsite = member.link_with(:text => /Personal website/).href
		end	
		
		electoralAddress = ""

		# SET REGION ID (refer data table in db)
		region_id = 72

		# GET REGION NAME & CODES
		region_name = "united_kingdom"
		region = "EU-UK"
		region_code_alliance = "EU"
		region_code_nation = "UK"
		region_code_state = ""
		region_code_county = ""
		region_code_city = ""

		constituency_name = ""
		constituency = ""
		constituency_code_alliance = "EU"
		constituency_code_nation = "UK"
		constituency_code_state = ""
		constituency_code_county = ""
		constituency_code_city = ""

		institution = ""

		# Political Activities
		activities = [];

		title = ""
		  
		search_link = member.links_with search: '.appearances+ p a'

		if search_link[0]
			ap = search_link[0].click

			activity_list = ap.search('.search-result--generic')
			
			activity_list.each do |list| 
			 	# ACTIVITY DATE
			  	activity_date = list.search('.search-result__title').text.strip
			  	date = activity_date.scan(/\w+/).values_at(-1, -2, -3)
			  	activity_date = "#{date[2]}/#{date[1]}/#{date[0]}" 
			  	activity_date = activity_date.to_time.strftime('%d/%m/%Y 00:00')
			
			  	# ACTIVITY NAME
			  	activity_name = list.search('.search-result__title a').text.strip
			
			  	# ACTIVITY LINK
				activity_link = list.at('.search-result__title a[href]').to_s
				activity_url = ""
				match = /href\s*=\s*"([^"]*)"/.match(activity_link)
				if match
					activity_url = match[1]
				end

				if activity_url != ""
					activity_url = "http://www.theyworkforyou.com" + activity_url   
				end	

				# FINAL ACTIVITY
			  	activity = activity_date + "|" + activity_name + "|" + activity_url
			  	activities.push(activity)
			  	#puts "ACTIVITY is: #{activity}"		  
			  end	
		  	end
		 

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
		lastActivity1Action = ""
		lastActivity2Action = ""
		lastActivity3Action = ""
		lastActivity4Action = ""
		lastActivity5Action = ""
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
		    elsif counter == 4
		 		lastActivity4Date = activity.split('|')[0]
		 		lastActivity4 = activity.split('|')[1]
		    	lastActivity4Link = activity.split('|')[2]
		    elsif counter == 5
		 		lastActivity5Date = activity.split('|')[0]
		 		lastActivity5 = activity.split('|')[1]
		    	lastActivity5Link = activity.split('|')[2]		
		   	end	

		   	counter += 1
		end  

		#puts "#{name} | #{birthday} | #{picture} | #{politicalParty} | #{lastActivity5Date} | #{lastActivity5} | #{lastActivity5Link}  "

		# GENERATE JSON
		{
			sourceWebsite: source,	
			name: name.strip,
			picture: picture,
			politicalParty: politicalParty,
			political_leaning_index: leaning_index,
			ideology1: leaning_index,
			ideology2: leaning_index,
			ideology3: leaning_index,
			ideology4: leaning_index,
			ideology5: leaning_index,
			bio: bio,
			lastActivity1Date:lastActivity1Date,
			lastActivity2Date:lastActivity2Date,
			lastActivity3Date:lastActivity3Date,
			lastActivity4Date:lastActivity4Date,
			lastActivity5Date:lastActivity5Date,
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
			electoralAddress: electoralAddress,
			region_id: region_id,
			region:region_name,
			region_code_alliance:region_code_alliance,
			region_code_nation:region_code_nation,
			region_code_state:region_code_state,
			region_code_county:region_code_county,
			region_code_city:region_code_city,
			constituency:constituency_name,
			constituency_code_alliance:constituency_code_alliance,
			constituency_code_nation:constituency_code_nation,
			constituency_code_state:constituency_code_state,
			constituency_code_county:constituency_code_county,
			constituency_code_city:constituency_code_city,
			institution: institution,
			officialWebsite: officialWebsite
		}
	end
	#puts JSON.pretty_generate(members)
	Datum.create!(members)
	

	# Set country as scraped
	#country = Country.find_by_region(region_id)
	#country.scraped = true
	#country.save


	puts "Scrapping ENDS... #{Time.now}"
	#puts "Total number of records being scraped: #{count}"

end