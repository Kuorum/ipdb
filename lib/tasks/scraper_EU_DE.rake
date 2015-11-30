require 'mechanize'
require 'date'
require 'time'
require 'json'

# REGION_ID [development]
region_id = 411
# REGION_ID [production]
#region_id = 0


region_abbreviation = 'EU-DE' 

task :scraper_EU_DE => [:environment] do

	agent = Mechanize.new

	last_page_number = 14

	for pg_number in 1..last_page_number do

		puts "Scrapping BEGINS... #{Time.now}"
		puts "Scrapping page #{pg_number} ..."

		page = agent.get("http://www.abgeordnetenwatch.de/abgeordnete-1128-0-#{pg_number}.html#profile")

		page_links = page.links_with(href: %r{.*-778-\w+})
		member_links = page_links		
		members = member_links.map do |link|	

			member = link.click

			source = link.href
			source = "http://www.abgeordnetenwatch.de/" + source

			profile_heading = member.search(".profil_name").text.strip
			name = profile_heading.split("(")[0]

			politicalParty = profile_heading.scan(/\(([^\)]+)\)/).last.first

			picture = ""
			if agent.page.image_with(:src => /big/)
			picture = agent.page.image_with(:src => /big/).to_s()	
			end	

			box1 = member.search('.box1 div').to_s.gsub('/t','').strip
			box1 = box1.gsub('<div class="title_data">','|')
			box1 = box1.gsub('</div>','|')

			dateOfBirth = box1.split('|')[2].strip
			if dateOfBirth.length == 10 || dateOfBirth.length > 8
				dateOfBirth = dateOfBirth.to_time.strftime('%d/%m/%Y 00:00') 
			else
				dateOfBirth = "01/01/" + dateOfBirth 	
			end

			constituency = box1.split('|')[10].strip
			constituency = constituency.split('<i>')[0]
			constituency = constituency.gsub('</a>','')
			constituency = constituency.split('>')[1]

			activity_name = ""
			activity_action = ""
			activity_outcome = ""
			activity_link = ""
			activity_date = ""

		 	activities = []
		 	activity_list = member.search(".entry")

		 	activity_list.each do |activity|
				if activity.search(".entry_title a")
					activity_name = activity.search(".entry_title a").text.strip
				end

				if activity.search(".entry .title_data")
					activity_date = activity.search(".title_data").text.strip
					activity_date = activity_date.to_time.strftime('%d/%m/%Y 00:00') 
				end	

				if activity.search(".verhalten")
					activity_action = activity.search(".verhalten").text.strip
				end	


				if activity.at(".entry_title a[href]").to_s
					temp_link = activity.search(".entry_title a").to_s
					match = /href\s*=\s*"([^"]*)"/.match(temp_link)
					if match
						activity_link = match[1]
					end
				end

				# FINAL ACTIVITY
			  	activity = activity_date + "|" + activity_name + "|" +  activity_action + "|" + activity_link
			  	activities.push(activity)
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

			activity_counter = 1
			activities.each do |activity|  	
				if activity_counter == 1
				  	lastActivity1Date = activity.split('|')[0]
				  	lastActivity1 = activity.split('|')[1]
				  	lastActivity1Action = activity.split('|')[2]
				  	lastActivity1Link = activity.split('|')[3]
			  	elsif activity_counter == 2
			  		lastActivity2Date = activity.split('|')[0]
			  		lastActivity2 = activity.split('|')[1]
			  		lastActivity2Action = activity.split('|')[2]
			  		lastActivity2Link = activity.split('|')[3]
			  	elsif activity_counter == 3
			 		lastActivity3Date = activity.split('|')[0]
			 		lastActivity3 = activity.split('|')[1]
			 		lastActivity3Action = activity.split('|')[2]
			    	lastActivity3Link = activity.split('|')[3]
			    elsif activity_counter == 4
			 		lastActivity4Date = activity.split('|')[0]
			 		lastActivity4 = activity.split('|')[1]
			 		lastActivity4Action = activity.split('|')[2]
			    	lastActivity4Link = activity.split('|')[3]
			    elsif activity_counter == 5
			 		lastActivity5Date = activity.split('|')[0]
			 		lastActivity5 = activity.split('|')[1]
			 		lastActivity5Action = activity.split('|')[2]
			    	lastActivity5Link = activity.split('|')[3]		
			   	end	

			   	activity_counter += 1
			end  

		   	activity_link_counter = 1
			activity_links = member.links_with search: '.entry_title a'
			activity_links.each do |activity_link|
				activity_link_page = activity_link.click

				vote1 = activity_link_page.search('.vote:nth-child(2) li:nth-child(1)').text.strip
				vote1 = vote1.split('/')[1]
				vote1 = vote1.gsub('Stimmen','').strip
				vote1 = vote1.to_i

				vote2 = activity_link_page.search('.vote:nth-child(2) li:nth-child(2)').text.strip
				vote2 = vote2.split('/')[1]
				vote2 = vote2.gsub('Stimmen','').strip
				vote2 = vote2.to_i
				
				if vote1 > vote2
					activity_outcome = "zugestimmt"
				else
					activity_outcome = "dagegen gestimmt"
				end	

				if activity_link_counter == 1
					lastActivity1Outcome = activity_outcome
				elsif activity_link_counter == 2
					lastActivity2Outcome = activity_outcome
				elsif activity_link_counter == 3
					lastActivity3Outcome = activity_outcome
				elsif activity_link_counter == 4
					lastActivity4Outcome = activity_outcome
				elsif activity_link_counter == 5
					lastActivity5Outcome = activity_outcome
				else
				end	
					
				activity_link_counter += 1
			end	

			
			# GET REGION NAME & CODES
			region_name = "germany"
			region = "EU-DE"
			region_code_alliance = "EU"
			region_code_nation = "DE"
			region_code_state = ""
			region_code_county = ""
			region_code_city = ""

			constituency_name = ""
			constituency = ""
			constituency_code_alliance = "EU"
			constituency_code_nation = "DE"
			constituency_code_state = ""
			constituency_code_county = ""
			constituency_code_city = ""

			electoralAddress = constituency
			institution = "Bundestag"


			# GENERATE JSON
			{
				sourceWebsite: source,	
				name: name,
				picture: picture,
				politicalParty: politicalParty,
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
				institution: institution
			}

		end

		#puts JSON.pretty_generate(members)

		# Insert data to database
		Datum.create!(members)

		puts "Scrapping ENDS... #{Time.now}"
	
	end

end