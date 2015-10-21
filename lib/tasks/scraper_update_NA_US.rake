require 'mechanize'
require 'date'
require 'json'
require 'rake-progressbar'

region = '233' 
region_abbreviation = 'NA-US' #Unites States
source = 'https://www.congress.gov/'

task :scraper_update_NA_US => [:environment] do

	agent = Mechanize.new

	last_page_number = 1

	for pg_number in 1..last_page_number do

		puts "Scrapping..."

		page = agent.get("https://www.congress.gov/members?page=#{pg_number}")
		page_links = page.links_with(href: %r{.*/member/\w+})

		page_links_size = page_links.size

		member_links = page_links
		#bar = RakeProgressbar.new(page_links_size)

		members = member_links.map do |link|		

		  member = link.click

		  # Get name
		  name = member.search('title').text.split('|')[0]

		  # Get bio
		  bio_page = member.link_with(:text => /Read biography/).click
		  bio = bio_page.search('p').text.gsub(/\r?\n/, '') #gsub strips the /n /r

		  # Get Activity
		  activity_list = member.search('#main li')
		  activities = [];
		  activity_list.each do |link| 
		  	activity_name = link.search('h2').text.strip
		  	activity_description = link.search('h3').text.strip

		  	activity = activity_name + "|" + activity_description

		  	activities.push(activity)

		  end
		  stripActivities = activities.reject { |x| x.length  == 1 }

		  # Update Data
		  #puts name
		  #data = Datum.find_by_name(name)  ## need to put if find name is success?

		  #puts name

		  #data = Datum.where("name = ?", name.strip)

		  datas = Datum.where(:name => name )
		  
		  #puts data.size

			if (datas.size > 0)			
				
				datas.each do |data|
					puts data.name
					data.bio = bio
				  	data.lastActivity1 = stripActivities[1]
				  	data.lastActivity2 = stripActivities[2]
				  	data.lastActivity3 = stripActivities[3]
				  	data.save

				  	if data.save					    
					    region = Region.find_by_region('233')
						region.touch
						puts "Update successfull! #{Time.now}"
					else
						puts "Update Unsuccessfull! #{Time.now}"	
					end
					
				end
			
			end  	

		  #if (data)

		  #	data = Datum.where(:name => name )  			
		  	#data.bio = bio
	      	#data.lastActivity1 = stripActivities[1]
		  	#data.lastActivity2 = stripActivities[2]
		  	#data.lastActivity3 = stripActivities[3]
	      	#data.save
		  
		  #end

		end

		#puts JSON.pretty_generate(members)
		
		#bar.finished

		 

		puts "Scrapping ENDS..."

	end

end