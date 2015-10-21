require 'mechanize'
require 'date'
require 'time'
require 'json'


region_abbreviation = 'NA-US' #Unites States
source = 'https://www.congress.gov/'

task :scraper_NA_US => [:environment] do

	agent = Mechanize.new

	last_page_number = 9

	for pg_number in 1..last_page_number do

		puts "Scrapping BEGINS... #{Time.now}"
		puts "Scrapping page #{pg_number} ..."

		page = agent.get("https://www.congress.gov/members?pageSize=250&page=#{pg_number}")
		page_links = page.links_with(href: %r{.*/member/\w+})

		member_links = page_links
		
		members = member_links.map do |link|		

		  member = link.click

		  # Get name
		  name = member.search('title').text.split('|')[0]
		  
		  # Get profile picture
		  picture = agent.page.image_with(:src => /member/).to_s()

		  # Get Political party
		  politicalParty = member.search('.member_party+ td').text.strip 

			# Get Date of Birth
			get_dateOfBirth = member.search('.birthdate').text.strip[1..4]
			dateOfBirth = "01/01/" +  get_dateOfBirth

			# Get electoral Address
			electoralAddress = member.search('.member_contact+ td').text.strip

			 
			# Get website
			website = member.search('.member_website+ td').text.strip 

			# Get institution
			institution = member.search('td~ td+ td')[0].text.strip.split(':')[0]

			# SET REGION ID (refer data table in db)
			region_id = 233

			# GET REGION NAME & CODES
			region_name = "united_states_of_america"
			region = "NA-US"
			region_code_alliance = "NA"
			region_code_nation = "US"
			region_code_state = ""
			region_code_county = ""
			region_code_city = ""

			# GET CONSTITUENCY NAME & CODES
			state_code = ""
			state_name = member.search('td:nth-child(1)')[0].text.strip.downcase
			regions = Region.all 
			regions.each do |region|
				if (region.name.downcase == state_name) 
					state_code = region.iso3166_2
				end
			end	

			constituency_name = state_name.downcase.gsub(/\s/, '_')
			constituency = state_code
			constituency_code_alliance = "NA"
			constituency_code_nation = "US"
			constituency_code_state = state_code.split('-')[2]
			constituency_code_county = ""
			constituency_code_city = ""

		  leaning_index = 0.0

		  # Get leaning index
		  parties = PoliticalParty.where(:name => politicalParty)
		  parties.each do |p|
		  	#puts "leaning index is: #{p.leaning_index}"
		  	leaning_index += p.leaning_index
		  end	

		  # Get bio
		  bio_page = member.link_with(:text => /Read biography/).click
		  bio = bio_page.search('p').text.gsub(/\r?\n/, '') #gsub strips the /n /r

		  # Get Activity
		  activity_list = member.search('#main li')
		  activities = [];
		  activity_list.each do |link| 

		  	# GET DATE
		  	first_row = link.search('tr:nth-child(1) td').text.strip
		  	activity_date = first_row.match(/(\d{2}\/\d{2}\/\d{4})/).to_s
		  	activity_date_day = activity_date[3..4]
		  	activity_date_month = activity_date[0..1]
		  	activity_date_year = activity_date[6..9]
		  	combined_activity_date = "#{activity_date_day}/#{activity_date_month}/#{activity_date_year}"

		  	# ACTIVITY NAME
		  	activity_name = link.search('h3').text.strip

		  	# ACTIVITY ACTION
		    if first_row.downcase.include?  name.downcase
		    	activity_action = "Sponsored"
		    else	
		    	activity_action = "Participate"
		    end	

		    # ACTIVITY OUTCOME
		    activity_outcome = link.search('.stat_leg .selected')
			activity_outcome.search('//div').each {|x| x.remove}
			strip_outcome = activity_outcome.text.strip

			# ACTIVITY LINK
			activity_link = link.at('h2 a[href]').to_s

		  	# FINAL ACTIVITY
		  	activity = combined_activity_date + "|" + activity_name + "|" +  activity_action + "|" + strip_outcome + "|" + activity_link 

		  	#puts strip_outcome

		  	if (combined_activity_date != "") && (activity_name != "") && (activity_action != "") && (activity_outcome != "") && (activity_link != "")  
		  		activities.push(activity)
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
			  	lastActivity1Action = activity.split('|')[2]
			  	lastActivity1Outcome = activity.split('|')[3]
			  	lastActivity1Link = activity.split('|')[4]
		  	elsif counter == 2
		  		lastActivity2Date = activity.split('|')[0]
		  		lastActivity2 = activity.split('|')[1]
		  		lastActivity2Action = activity.split('|')[2]
		  		lastActivity2Outcome = activity.split('|')[3]
		  		lastActivity2Link = activity.split('|')[4]
		  	elsif counter == 3
		 		lastActivity3Date = activity.split('|')[0]
		 		lastActivity3 = activity.split('|')[1]
		 		lastActivity3Action = activity.split('|')[2]
		    	lastActivity3Outcome = activity.split('|')[3]
		    	lastActivity3Link = activity.split('|')[4]
		    elsif counter == 4	
		   		lastActivity4Date = activity.split('|')[0]
   				lastActivity4 = activity.split('|')[1]
		    	lastActivity4Action = activity.split('|')[2]
		    	lastActivity4Outcome = activity.split('|')[3]
		    	lastActivity4Link = activity.split('|')[4]
		    else
		    	lastActivity5Date = activity.split('|')[0]
		    	lastActivity5 = activity.split('|')[1]
		    	lastActivity5Action = activity.split('|')[2]
		   		lastActivity5Outcome =  activity.split('|')[3]
		   		lastActivity5Link = activity.split('|')[4]
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

		  if (lastActivity4Date != "") 
		  	converted_ldate4 = lastActivity4Date.to_time.strftime('%d/%m/%Y 00:00')
		  else
		    converted_ldate4 = lastActivity4Date
		  end

		  if (lastActivity5Date != "") 
		  	converted_ldate5 = lastActivity5Date.to_time.strftime('%d/%m/%Y 00:00')
		  else
		    converted_ldate5 = lastActivity5Date
		  end
		   
		  #stripActivities = activities.reject { |x| x.length  == 1 }
		  #stripActivities = activities.reject { |x| x  == "||" }

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

		  match = /href\s*=\s*"([^"]*)"/.match(lastActivity4Link)
		  if match
			url4 = match[1]
		  end

		  match = /href\s*=\s*"([^"]*)"/.match(lastActivity5Link)
		  if match
			url5 = match[1]
		  end


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
		    lastActivity1Date:converted_ldate1,
		    lastActivity2Date:converted_ldate2,
		    lastActivity3Date:converted_ldate3,
		    lastActivity4Date:converted_ldate4,
		    lastActivity5Date:converted_ldate5,
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
		    lastActivity1Link:url1,
		    lastActivity2Link:url2,
		    lastActivity3Link:url3,
		    lastActivity4Link:url4,
		    lastActivity5Link:url5,
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
		    constituency: constituency,
		    officialWebsite: website
		  }


		end

		#puts JSON.pretty_generate(members)


		# Insert data to database
		Datum.create!(members)


		# Set country as scraped
		#country = Country.find_by_region(region_id)
		#country.scraped = true
		#country.save


		puts "Scrapping ENDS... #{Time.now}"
		#puts "Total number of records being scraped: #{count}"

	end

end