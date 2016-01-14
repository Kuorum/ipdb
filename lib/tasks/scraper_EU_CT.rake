require 'mechanize'
require 'date'
require 'time'
require 'json'

region_abbreviation = 'EU_CT' # Espana (Spain)

task :scraper_EU_CT => [:environment] do

	agent = Mechanize.new

	puts "Scrapping BEGINS... #{Time.now}"

	page = agent.get("http://www.parlament.cat/web/composicio/ple-parlament/index.html")
	page_links = page.links_with search: '.span9 a'			

	member_links = page_links
	
	member_counter = 0
	members = member_links.map do |link|	

		sourceWebsite = "http://www.parlament.cat" + link.href
		p_codi = sourceWebsite.split('=')[1]
		 
		member = link.click

		name = ""
		completeName = ""
		picture = ""
		politicalParty = ""
		bio = ""
		email_url = ""
		blog_url = ""
		twitter_url = ""
		facebook_url = ""
		declaration_url = ""
		institutionalAddress = ""
		institutionalTelephone = ""

		completeName = member.search('.titol_pagina span').text.strip 
		if completeName.include? "M. H. Sra."
			name =  completeName.gsub("M. H. Sra.",'').strip 
		elsif completeName.include? "I. Sra."
			name =  completeName.gsub('I. Sra.','').strip 
		elsif completeName.include? "M. H. Sr."
			name =  completeName.gsub('M. H. Sr.','').strip 
		elsif completeName.include? "I. Sr."
			name =  completeName.gsub('I. Sr.','').strip 
		elsif completeName.include? "H. Sr."
			name =  completeName.gsub('H. Sr.','').strip 
		elsif completeName.include? "H. Sra."
			name =  completeName.gsub('H. Sra.','')	.strip 
		elsif completeName.include? "Il·lm."
			name =  completeName.gsub('Il·lm.','').strip 
		elsif completeName.include? "Il·lma."
			name =  completeName.gsub('Il·lma.','').strip 
		elsif completeName.include? "Il·lm. Sr."
			name =  completeName.gsub('Il·lm. Sr.','').strip 
		elsif completeName.include? "Sr."
			name =  completeName.gsub('Sr.','').strip 
		elsif completeName.include? "Sra."
			name =  completeName.gsub('Sra.','').strip 
		else	
		end

		if name.include? "Sr."
			name =  name.gsub('Sr.','').strip 
		elsif name.include? "Sra."
			name =  name.gsub('Sra.','').strip 
		end	

		#puts "#{completeName} | #{name}"


		if agent.page.image_with(:src => /imgweb/)
			picture = agent.page.image_with(:src => /imgweb/).to_s()	
		end

		politicalParty = member.search('dd:nth-child(6)').text.strip 

		
		if member.search('.text:nth-child(3)')
			bio = member.search('.text:nth-child(3)').text.strip
		end	

		email = member.at(".email a[href]").to_s
		match = /href\s*=\s*"([^"]*)"/.match(email)
		if match
			email_url = match[1]
		end
		email_url = email_url.split(":")[1] 

		blog = member.at(".blog a[href]").to_s
		match = /href\s*=\s*"([^"]*)"/.match(blog)
		if match
			blog_url = match[1]
		end

		twitter = member.at(".twitter a[href]").to_s
		match = /href\s*=\s*"([^"]*)"/.match(twitter)
		if match
			twitter_url = match[1]
		end

		facebook = member.at(".facebook a[href]").to_s
		match = /href\s*=\s*"([^"]*)"/.match(facebook)
		if match
			facebook_url = match[1]
		end

		institution = "Parlament de Catalunya"

		declaration = member.at("li:nth-child(2) .contingut_breu a[href]").to_s
		match = /href\s*=\s*"([^"]*)"/.match(declaration)
		if match
			declaration_url =  "http://www.parlament.cat" + match[1]
		end

		#institutionalAddress = member.search('.filiacio p').text.strip
		address_page = agent.get("http://www.parlament.cat/conssiapinternet/adrecesPersonesAction.do?criteri=#{p_codi}")
		address1 = address_page.search('tr:nth-child(1) .siaptitolcamp').text.strip
		address2 = address_page.search('tr:nth-child(2) .siaptitolcamp').text.strip
		address3 = address_page.search('tr:nth-child(3) .siaptitolcamp').text.strip
		address4 = address_page.search('tr:nth-child(4) .siaptitolcamp').text.strip

		
		if address1 != "" && address2 != "" && address3 != "" && address4 != "" 
			institutionalAddress = "#{address1}, #{address4}, #{address2}"
		end
		institutionalTelephone = address_page.search('tr:nth-child(5) .siaptitolcamp').text.strip

		# GET REGION NAME & CODES
		region_id = 22
		region_name = "cataluna"	
		region_code_alliance = "EU"
		region_code_nation = "EU-ES"
		region_code_state = "EU-ES-CT"
		region_code_county = ""
		region_code_city = ""

		consituency_search = member.search('dd:nth-child(4)').text.strip
		constituency_name = consituency_search.split('de')[1]
		constituency_name = constituency_name.gsub('.','')
		constituency_name = constituency_name.gsub(' ','')

		constituency = ""
		constituency_name = constituency_name.downcase 
		regions = Region.where(:name => constituency_name).where("length(iso3166_2) = 11")
		regions.each do |region|
			constituency = region.iso3166_2				
		end	

		constituency_code_alliance = "EU"
		constituency_code_nation = "EU-ES"
		constituency_code_state = "EU-ES-CT"
		constituency_code_county = constituency
		constituency_code_city = ""

		member_counter += 1


		# GENERATE JSON
		{
			sourceWebsite: sourceWebsite,	
			name: name,
			completeName: completeName,
			picture: picture,
			politicalParty: politicalParty,
			bio: bio,
			email: email_url,
			blog: blog_url,
			twitter: twitter_url,
			facebook: facebook_url,
			declarationLink: declaration_url,
			institutionalAddress: institutionalAddress,
			institutionalTelephone: institutionalTelephone,
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

	puts JSON.pretty_generate(members)

	# Insert data to database
	Datum.create!(members)

	puts "Scrapping ENDS... #{Time.now}"

end