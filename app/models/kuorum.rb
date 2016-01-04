class Kuorum
	include HTTPParty

	base_uri 'http://api.kuorum.org:80/api/geolocation/find'
	headers {:key => "IPDB"}
	format :json

	def self.find(regionName)
		response = get("#{regionName}.json")
		
	end
end	