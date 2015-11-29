require 'mechanize'
require 'date'
require 'time'
require 'json'


task :fix_iso => [:environment] do

	datum = Datum.where(:region_id => "2")
	
	datum.each do |data|
		#details = "#{data.name} | #{data.region_code_alliance} | #{data.region_code_nation} | #{data.constituency_code_alliance} | #{data.constituency_code_nation} | #{data.constituency_code_state}" 
		#puts details 

		data_id = data.id
		original_contituency = data.constituency.gsub("_"," ")
		original_contituency_code = ""

		region_code_alliance = "EU"
		region_code_nation = "EU-ES"

		constituency_code_alliance = "EU"
		constituency_code_nation = "EU-ES"
		constituency_code_state = ""
		constituency_code_county = ""

		constituency_length = ""

		region = Region.where("lower(name) = ?", original_contituency.downcase).group(:name)
		region.each do |r|
			original_contituency_code = r.iso3166_2

			constituency_length = r.iso3166_2.length
			if constituency_length == 8
				constituency_code_state = original_contituency_code
			else
				constituency_code_state = original_contituency_code[0..7]
				constituency_code_county = original_contituency_code
			end 	

		end	

		#puts "#{data.name} | #{original_contituency.downcase} | #{original_contituency_code} | #{constituency_code_state} | #{constituency_code_county}"

		u_data = Datum.find(data_id)
		u_data.region_code_alliance = region_code_alliance
		u_data.region_code_nation = region_code_nation
		u_data.constituency_code_alliance = constituency_code_alliance
		u_data.constituency_code_nation = constituency_code_nation
		u_data.constituency_code_state = constituency_code_state
		u_data.constituency_code_county = constituency_code_county
		u_data.save

	end 

end