require 'mechanize'
require 'date'
require 'json'
require 'rake-progressbar'

region = 'US'
source = 'https://www.congress.gov/'

task :scrape_US => [:environment] do

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
		  
		  # Get profile picture
		  picture = agent.page.image_with(:src => /member/).to_s()

		  # Get Political party
		  politicalParty = member.search('.member_party+ td').text.strip 

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


		  # Get Date of Birth
		  dateOfBirth = member.search('.birthdate').text.strip[1..4]

		  # Get electoral Address
		  electoralAddress = member.search('.member_contact+ td').text.strip

		  # Get constituency
		  constituency = member.search('td:nth-child(1)').text.strip 

		  # Get website
		  website = member.search('.member_website+ td').text.strip 

		  # Get institution
		  institution = member.search('td~ td+ td').text.split(':')[0]
  

		  {
		  	sourceWebsite: source,	
		    name: name.strip,
		    picture: picture,
		    politicalParty: politicalParty,
		    bio: bio,
		    lastActivity1: stripActivities[1],
		    lastActivity2: stripActivities[2],
		    lastActivity3: stripActivities[3],
		    dateOfBirth: dateOfBirth,
		    electoralAddress: electoralAddress,
		    region: region,
		    institution: institution.strip,
		    constituency: constituency,
		    officialWebsite: website
		  }

		  #bar.inc

		end

		puts JSON.pretty_generate(members)


		# Insert data to database
		Datum.create!(members)


		# Set country as scraped
	    country = Country.find_by_abbreviation(region)
	    country.scraped = true
	    country.save

		
		#bar.finished

		puts "Scrapping ENDS..."

	end

end