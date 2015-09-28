require 'mechanize'
require 'date'
require 'json'
require 'rake-progressbar'

REGION = 'US'
SOURCE = 'https://www.congress.gov/'

name = "";

task :scrape_update_US => [:environment] do

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

		  name = member.search('title').text.split('|')[0]
		  institution = member.search('td~ td+ td').text.split(':')[0]
		  dob = member.search('.birthdate').text.strip[1..4]

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
		  

		  {
		    bio: bio
		  }

		  #bar.inc

		end

		puts JSON.pretty_generate(members)


		# Insert data to database
		data = Datum.where(:name => name, :source => SOURCE)
		data.update!(members)

		
		#bar.finished

		puts "Scrapping ENDS..."

	end

end